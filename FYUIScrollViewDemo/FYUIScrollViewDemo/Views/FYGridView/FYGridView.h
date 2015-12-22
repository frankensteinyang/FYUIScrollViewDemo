//
//  FYGridView.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/20/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FYGridViewStylePush = 0,
    FYGridViewStyleSwap
} FYGridViewStyle;

@protocol FYGridViewDataSource;
@protocol FYGridViewActionDelegate;
@protocol FYGridViewSortingDelegate;
@protocol FYGridViewTransformationDelegate;
@protocol FYGridViewLayoutStrategy;

@interface FYGridView : UIView

@property (nonatomic, weak) NSObject <FYGridViewDataSource> *dataSource;
@property (nonatomic, weak) NSObject <FYGridViewActionDelegate> *actionDelegate;
@property (nonatomic, weak) NSObject <FYGridViewSortingDelegate> *sortingDelegate;
@property (nonatomic, weak) NSObject <FYGridViewTransformationDelegate> *transformDelegate;
@property (nonatomic, strong) id <FYGridViewLayoutStrategy> layoutStrategy;
@property (nonatomic, getter=isEditing) BOOL editing;
@property (nonatomic, weak) UIView *mainSuperView;
@property (nonatomic) FYGridViewStyle style;
@property (nonatomic) NSInteger itemSpacing;
@property (nonatomic) NSInteger itemHSpacing;
@property (nonatomic) BOOL centerGrid;
@property (nonatomic) UIEdgeInsets minimumPressDuration;
@property (nonatomic) BOOL showFullSizeViewWithAlphaWhenTransforming;
@property (nonatomic) BOOL showsVerticalScrollIndicator;
@property (nonatomic) BOOL showsHorizontalScrollIndicator;
@property (nonatomic, readonly) UIScrollView *scrollView;

@end
