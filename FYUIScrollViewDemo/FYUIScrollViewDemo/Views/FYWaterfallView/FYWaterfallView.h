//
//  FYWaterfallView.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/6/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FYWaterfallView;

@protocol FYWaterfallViewDataSource <NSObject>

@required
- (NSUInteger)numberOfCellsInWaterfallView:(FYWaterfallView *)waterfallView;

@end

@interface FYWaterfallView : UIScrollView

@property (nonatomic, weak) id<FYWaterfallViewDataSource> dataSource;

@end
