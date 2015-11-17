//
//  FYBannerView.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/17/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYBannerView.h"

@interface FYBannerView ()

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation FYBannerView

- (instancetype)initWithBlock:(FYBannerViewBlock)block {
    
    self = [super init];
    if (self) {
        [self addSubview:self.pageControl];
        //
    }
    return self;
}

@end
