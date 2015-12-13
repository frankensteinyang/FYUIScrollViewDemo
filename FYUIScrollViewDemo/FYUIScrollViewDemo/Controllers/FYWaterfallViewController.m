//
//  FYWaterfallViewController.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYWaterfallViewController.h"
#import "FYWaterfallView.h"

@interface FYWaterfallViewController () <FYWaterfallViewDataSource, FYWaterfallViewDelegate>

@end

@implementation FYWaterfallViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    FYWaterfallView *waterfallView = [[FYWaterfallView alloc] init];
    waterfallView.frame = self.view.bounds;
    waterfallView.dataSource = self;
    waterfallView.delegate = self;
    [self.view addSubview:waterfallView];
}

- (FYWaterfallViewCell *)waterfallView:(FYWaterfallView *)waterfallView cellAtIndex:(NSUInteger)index {
    
    return nil;
}

- (NSUInteger)numberOfCellsInWaterfallView:(FYWaterfallView *)waterfallView {
    return 2;
}

@end
