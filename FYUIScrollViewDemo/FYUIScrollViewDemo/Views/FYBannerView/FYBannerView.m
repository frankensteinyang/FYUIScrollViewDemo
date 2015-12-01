//
//  FYBannerView.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/17/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <libextobjc/EXTScope.h>

#import "FYBannerView.h"
#import "FYDefine.h"
#import "FYBannerItemView.h"
#import "FYImageDataModel.h"
#import "FYHelper.h"
#import "FYStore.h"
#import "FYConfigurationModel.h"

#define kITEM_WIDTH  (self.frame.size.width)
#define kITEM_HEIGHT (self.frame.size.height)

@interface FYBannerView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl     *pageControl;
@property (nonatomic, strong) UIScrollView      *scrollView;
@property (nonatomic, strong) NSTimer           *timer;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@property (nonatomic, assign) CFTimeInterval    lastUpdateTimeMarker;
@property (nonatomic, copy  ) FYBannerViewBlock bannerBlock;

@end

@implementation FYBannerView

- (void)dealloc {
    _scrollView.delegate = nil;
    _scrollView = nil;
    _pageControl = nil;
    _timer = nil;
    if (_bannerBlock) {
        _bannerBlock = nil;
    }
}

- (instancetype)initWithBlock:(FYBannerViewBlock)block {
    
    self = [super init];
    if (self) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        [self makeConstraint];
        _bannerBlock = [block copy];
    }
    return self;
}

#pragma mark - 懒加载

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        UITapGestureRecognizer *recognizer =
        [[UITapGestureRecognizer alloc]
         initWithTarget:self action:@selector(scrollViewClicked:)];
        [_scrollView addGestureRecognizer:recognizer];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl { 
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        if (!kFYIOS7_OR_LATER) {
            [_pageControl setBackgroundColor:[UIColor clearColor]];
        }
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

#pragma mark - Setters

- (void)setDataArray:(NSMutableArray *)dataArray {
    if (!dataArray || (dataArray && ![dataArray count])) {
        return;
    }
    _dataArray = dataArray;
    if (_dataArray.count) {
        self.pageControl.hidden = YES;
        self.scrollView.contentSize =
        CGSizeMake(kITEM_WIDTH * (_dataArray.count + 2), kITEM_HEIGHT);
        
        // central view
        for (NSInteger i = 0; i < _dataArray.count; i ++) {
            NSInteger tag = 169 + i;
            [self createScrollViewItemWithTag:tag
                                      andData:[_dataArray objectAtIndex:i]];
        }
        
        // left view
        NSInteger tag_right = 168;
        [self createScrollViewItemWithTag:tag_right
                                  andData:[_dataArray lastObject]];
        
        // right view
        NSInteger tag_left = 169 + [_dataArray count];
        [self createScrollViewItemWithTag:tag_left
                                  andData:[_dataArray firstObject]];
        
        [self setInitialPosition];
    }
}

#pragma mark - Private Methods

- (void)createScrollViewItemWithTag:(NSInteger)tag
                            andData:(FYImageDataModel *)model {
    if ([self.scrollView viewWithTag:tag]) {
        [[self.scrollView viewWithTag:tag] removeFromSuperview];
    }
    NSInteger placedTag;
    if (tag == 168) {
        placedTag = 0;
    } else if (tag == (169 + [_dataArray count])) {
        placedTag = [_dataArray count] + 1;
    } else {
        placedTag = (tag - 169) + 1;
    }
    FYBannerItemView *itemView = [[FYBannerItemView alloc] initWithFrame:
                                  CGRectMake(kITEM_WIDTH * placedTag, 0,
                                             kITEM_WIDTH, kITEM_HEIGHT)];
    itemView.tag = tag;
    @weakify(self);
    [FYHelper downloadImageWithUrl:model.image relatedLink:model.url
             downloadImageCallBack:^(UIImage *image, NSString *link) {
        @strongify(self);
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                itemView.url = link;
                [itemView.imgView setImage:image];
                if (self.pageControl.hidden) {
                    self.pageControl.hidden = NO;
                }
            });
        }
    }];
    [self.scrollView addSubview:itemView];
}

- (void)setInitialPosition {
    self.pageControl.numberOfPages = [_dataArray count];
    self.pageControl.currentPage = 0;
    [self scrollToIndex:0];
    CGFloat targetX = self.scrollView.contentOffset.x
    + self.scrollView.frame.size.width;
    targetX = (NSInteger)(targetX / kITEM_WIDTH) * kITEM_WIDTH;
    [self.scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
}

- (void)scrollToIndex:(NSInteger)aIndex {
    if ([self.dataArray count] > 1) {
        if (aIndex >= ([self.dataArray count])) {
            aIndex = [self.dataArray count] - 1;
        }
        [self.scrollView setContentOffset:
         CGPointMake(kITEM_WIDTH * (aIndex + 1), 0) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    [self scrollViewDidScroll:self.scrollView];
}

#pragma mark - Timer Methods

- (void)fireTimer {
    [self killTimer];
    NSInteger duration = [[FYStore sharedInstance].configModel.play_duration integerValue];
    _timer = [NSTimer scheduledTimerWithTimeInterval:duration
                                              target:self
                                            selector:@selector(goToNext)
                                            userInfo:nil
                                             repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)killTimer {
    if (_timer) {
        if ([_timer isValid]) {
            [_timer invalidate];
        }
    }
}

- (void)goToNext {
    CGFloat targetX = self.scrollView.contentOffset.x + self.scrollView.frame.size.width;
    targetX = (NSInteger)(targetX / kITEM_WIDTH) * kITEM_WIDTH;
    [self.scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES];
}

#pragma mark - Event Handlers

- (void)scrollViewClicked:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.scrollView];
    NSInteger page = (NSInteger)point.x / (NSInteger)self.frame.size.width;
    FYBannerItemView *itemView;
    NSInteger currentTag;
    if (page == 0) {
        currentTag = 168;
    } else if (page == [self.dataArray count] + 1) {
        currentTag = (169 + [_dataArray count]);
    } else {
        currentTag = (page - 1 + 169);
    }
    if ([self.scrollView viewWithTag:currentTag] &&
        [[self.scrollView viewWithTag:currentTag]
         isKindOfClass:[FYBannerItemView class]]) {
        itemView = [self.scrollView viewWithTag:currentTag];
    }
    if (itemView) {
        if (_bannerBlock) {
            if (itemView.url && [itemView.url length]) {
                _bannerBlock(itemView.url);
                for (FYImageDataModel *model in self.dataArray) {
                    if ([model.url isEqualToString:itemView.url]) {
                        [[FYStore sharedInstance] redirectURLWithContentID:
                         [model.contentID integerValue] redirectUrl:model.url];
                    }
                }
            }
        }
    }
}

#pragma mark - Constraints

- (void)makeConstraint {
    @weakify(self);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(self);
        make.center.mas_equalTo(self);
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.scrollView.mas_right).offset(-5);
        make.bottom.equalTo(self.scrollView.mas_bottom).offset(5);
        make.height.equalTo(@20);
    }];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self killTimer];
    CGFloat targetX = scrollView.contentOffset.x;
    if ([self.dataArray count] >= 1) {
        if (targetX >= kITEM_WIDTH * ([self.dataArray count] + 1)) {
            targetX = kITEM_WIDTH;
            [self.scrollView setContentOffset:
             CGPointMake(targetX, 0) animated:NO];
        } else if (targetX <= 0) {
            targetX = kITEM_WIDTH * [self.dataArray count];
            [self.scrollView setContentOffset:
             CGPointMake(targetX, 0) animated:NO];
        }
    }
    NSInteger page = (self.scrollView.contentOffset.x + kITEM_WIDTH / 2.0) / kITEM_WIDTH;
    if ([self.dataArray count] > 1) {
        page --;
        if (page >= self.pageControl.numberOfPages) {
            page = 0;
        } else if (page < 0) {
            page = self.pageControl.numberOfPages - 1;
        }
    }
    self.pageControl.currentPage = page;
    [self fireTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        targetX = (NSInteger)(targetX / kITEM_WIDTH) * kITEM_WIDTH;
        [self.scrollView setContentOffset:CGPointMake((NSInteger)targetX, 0) animated:YES];
    }
}

@end
