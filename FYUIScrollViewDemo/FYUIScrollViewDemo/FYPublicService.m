//
//  FYPublicService.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/18/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYPublicService.h"
#import "FYBannerService.h"

@implementation FYPublicService

+ (void)fy_getResource:(void (^)(UIView *))viewBlock
                   url:(void (^)(NSString *))urlBlock {
    [FYBannerService fy_getResource:^(UIView *bannerView) {
        if (viewBlock) {
            viewBlock(bannerView);
        }
    } url:^(NSString *url) {
        if (urlBlock) {
            urlBlock(url);
        }
    }];
}

@end
