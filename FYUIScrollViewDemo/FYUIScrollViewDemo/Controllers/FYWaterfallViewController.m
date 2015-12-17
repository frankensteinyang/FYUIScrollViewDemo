//
//  FYWaterfallViewController.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYWaterfallViewController.h"
#import "FYWaterfallView.h"
#import "FYCommodityModel.h"
#import "FYConverter.h"
#import "FYCommodityCell.h"

@interface FYWaterfallViewController () <FYWaterfallViewDataSource, FYWaterfallViewDelegate>

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
    
    NSArray *newCommodities = [FYCommodityModel objectArrayWithFilename:@"Goods.plist"];
    [self.commodities addObjectsFromArray:newCommodities];
    
    FYWaterfallView *waterfallView = [[FYWaterfallView alloc] init];
    waterfallView.backgroundColor = [UIColor blueColor];
    // 随着父控件的大小自动伸缩
    waterfallView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    waterfallView.frame = self.view.bounds;
    waterfallView.dataSource = self;
    waterfallView.delegate = self;
    [self.view addSubview:waterfallView];
    self.waterfallView = waterfallView;
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

@end
