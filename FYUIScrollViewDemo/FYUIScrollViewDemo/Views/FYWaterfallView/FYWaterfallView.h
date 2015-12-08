//
//  FYWaterfallView.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/6/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FYWaterfallViewMarginTypeTop,
    FYWaterfallViewMarginTypeBottom,
    FYWaterfallViewMarginTypeLeft,
    FYWaterfallViewMarginTypeRight,
    FYWaterfallViewMarginTypeColumn,
    FYWaterfallViewMarginTypeRow
} FYWaterfallViewMarginType;

@class FYWaterfallView, FYWaterfallViewCell;

@protocol FYWaterfallViewDataSource <NSObject>

@required
- (NSUInteger)numberOfCellsInWaterfallView:(FYWaterfallView *)waterfallView;
- (FYWaterfallViewCell *)waterfallView:(FYWaterfallView *)waterfallView
                           cellAtIndex:(NSUInteger)index;

@optional
- (NSUInteger)numberOfColumnsInWaterfallView:(FYWaterfallView *)waterfallView;

@end

@protocol FYWaterfallViewDelegate <UIScrollViewDelegate>

@end

@interface FYWaterfallView : UIScrollView

@property (nonatomic, weak) id<FYWaterfallViewDataSource> dataSource;
@property (nonatomic, weak) id<FYWaterfallViewDelegate> delegate;

@end

