//
//  FYWaterfallViewController.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <libextobjc/EXTScope.h>
#import <MJRefresh/MJRefresh.h>

#import "FYWaterfallViewController.h"
#import "FYWaterfallView.h"
#import "FYCommodityModel.h"
#import "FYConverter.h"
#import "FYCommodityCell.h"
#import "FYUIButton.h"

@interface FYWaterfallViewController () <FYWaterfallViewDataSource,
                                         FYWaterfallViewDelegate>

@property (nonatomic, strong) NSMutableArray *commodities;
@property (nonatomic, weak) FYWaterfallView *waterfallView;

@end

@implementation FYWaterfallViewController

- (NSMutableArray *)commodities {
    if (_commodities == nil) {
        self.commodities = [NSMutableArray array];
    }
    return _commodities;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSArray *coms = [FYCommodityModel objectArrayWithFilename:@"Goods.plist"];
    [self.commodities addObjectsFromArray:coms];
    
    FYUIButton *backBtn = [[FYUIButton alloc] initWithFrame:CGRectZero
                                                      style:FYUIButtonStyleTranslucent];
    backBtn.text = @"返回首页";
    backBtn.font = [UIFont systemFontOfSize:14.0f];
    backBtn.vibrancyEffect = nil;
    [backBtn addTarget:self
                action:@selector(backBtnClicked)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    FYWaterfallView *waterfallView = [[FYWaterfallView alloc] init];
    waterfallView.backgroundColor = [UIColor blueColor];
    // 随着父控件的大小自动伸缩
    waterfallView.autoresizingMask = UIViewAutoresizingFlexibleHeight |
                                     UIViewAutoresizingFlexibleWidth;
    waterfallView.dataSource = self;
    waterfallView.delegate = self;
    [self.view addSubview:waterfallView];
    self.waterfallView = waterfallView;
    
    @weakify(self);
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(160, 40));
        make.top.mas_equalTo(50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [waterfallView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(backBtn.mas_bottom).with.offset(10);
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height - 100;
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
    // 下拉刷新和上拉加载更多
    waterfallView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self
                                                         refreshingAction:@selector(pullToRefresh)];
    waterfallView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self
                                                         refreshingAction:@selector(loadMore)];
}

- (void)pullToRefresh {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *refresh = [FYCommodityModel objectArrayWithFilename:@"Goods.plist"];
        NSRange range = NSMakeRange(0, [refresh count]);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.commodities insertObjects:refresh
                              atIndexes:indexSet];
    });
    
    int64_t delta = (int64_t)(2.0 * NSEC_PER_SEC);
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delta);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self.waterfallView reloadData];
        [self.waterfallView.mj_header endRefreshing];
    });
}

- (void)loadMore {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *loadMore = [FYCommodityModel objectArrayWithFilename:@"Goods.plist"];
        [self.commodities addObjectsFromArray:loadMore];
    });
    
    int64_t delta = (int64_t)(2.0 * NSEC_PER_SEC);
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delta);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self.waterfallView reloadData];
        [self.waterfallView.mj_footer endRefreshing];
    });
}

#pragma mark - FYWaterfallViewDataSource

- (NSUInteger)numberOfCellsInWaterfallView:(FYWaterfallView *)waterfallView {
    return [self.commodities count];
}

- (FYWaterfallViewCell *)waterfallView:(FYWaterfallView *)waterfallView
                           cellAtIndex:(NSUInteger)index {
    FYCommodityCell *cell = [FYCommodityCell cellWithWaterfallView:waterfallView];
    cell.commodity = self.commodities[index];
    return cell;
}

- (NSUInteger)numberOfColumnsInWaterfallView:(FYWaterfallView *)waterfallView {
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        return 3;
    } else {
        return 5;
    }
}

#pragma mark - FYWaterfallViewDelegate

- (CGFloat)waterfallView:(FYWaterfallView *)waterfallView
           heightAtIndex:(NSUInteger)index {
    FYCommodityModel *model = self.commodities[index];
    return waterfallView.cellWidth * model.height / model.width;
}

- (void)backBtnClicked {
    [self dismissViewControllerAnimated:NO
                             completion:nil];
}

@end
