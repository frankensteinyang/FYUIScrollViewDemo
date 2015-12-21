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

/**
 *  瀑布流数据源
 */
@protocol FYWaterfallViewDataSource <NSObject>

@required

- (NSUInteger)numberOfCellsInWaterfallView:(FYWaterfallView *)waterfallView;
- (FYWaterfallViewCell *)waterfallView:(FYWaterfallView *)waterfallView
                           cellAtIndex:(NSUInteger)index;

@optional

- (NSUInteger)numberOfColumnsInWaterfallView:(FYWaterfallView *)waterfallView;

@end

/**
 *  瀑布流代理
 */
@protocol FYWaterfallViewDelegate <UIScrollViewDelegate>

@optional

- (CGFloat)waterfallView:(FYWaterfallView *)waterfallView
           heightAtIndex:(NSUInteger)index;
- (void)waterfallView:(FYWaterfallView *)waterfallView
     didSelectAtIndex:(NSUInteger)index;
- (CGFloat)waterfallView:(FYWaterfallView *)waterfallView
           marginForType:(FYWaterfallViewMarginType)type;

@end

@interface FYWaterfallView : UIScrollView

@property (nonatomic, weak) id<FYWaterfallViewDataSource> dataSource;
@property (nonatomic, weak) id<FYWaterfallViewDelegate> delegate;

/**
 *  刷新数据
 */
- (void)reloadData;

/**
 *  Cell的宽度
 */
- (CGFloat)cellWidth;

/**
 *  瀑布流Cell重用
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
// __kindof FYWaterfallViewCell *

@end

