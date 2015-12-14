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
    
//    NSArray *newCommodities = [FYCommodityModel object]
    FYWaterfallView *waterfallView = [[FYWaterfallView alloc] init];
    waterfallView.frame = self.view.bounds;
    waterfallView.dataSource = self;
    waterfallView.delegate = self;
    [self.view addSubview:waterfallView];
}

- (FYWaterfallViewCell *)waterfallView:(FYWaterfallView *)waterfallView
                           cellAtIndex:(NSUInteger)index {
    
    return nil;
}

- (NSUInteger)numberOfCellsInWaterfallView:(FYWaterfallView *)waterfallView {
    return 2;
}

@end
