//
//  FYCommodityCell.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYWaterfallViewCell.h"

@class FYWaterfallView, FYCommodityModel;

@interface FYCommodityCell : FYWaterfallViewCell

+ (instancetype)cellWithWaterfallView:(FYWaterfallView *)waterfallView;

@property (nonatomic, strong) FYCommodityModel *commodity;

@end
