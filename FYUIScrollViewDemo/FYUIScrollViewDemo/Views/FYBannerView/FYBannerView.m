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
                        // stop...
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
    
}

@end
