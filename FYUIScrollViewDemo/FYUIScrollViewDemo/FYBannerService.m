//
//  FYBannerService.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/18/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYBannerService.h"
#import "FYBannerView.h"

@implementation FYBannerService

+ (void)fy_getResource:(void (^)(UIView *))viewBlock
                   url:(void (^)(NSString *))urlBlock {
    if (viewBlock) {
        FYBannerView *bannerView = [[FYBannerView alloc]
                                    initWithBlock:^(NSString *url) {
            if (urlBlock) {
                urlBlock(url);
            }
        }];
        viewBlock(bannerView);
    }
}

@end
