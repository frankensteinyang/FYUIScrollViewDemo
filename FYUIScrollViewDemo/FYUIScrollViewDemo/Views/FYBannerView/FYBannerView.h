//
//  FYBannerView.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/17/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FYBannerViewBlock)(NSString *url);

@interface FYBannerView : UIScrollView

- (instancetype)initWithBlock:(FYBannerViewBlock)block;

@end
