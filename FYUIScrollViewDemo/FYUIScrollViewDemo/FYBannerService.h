//
//  FYBannerService.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/18/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FYBannerService : NSObject

+ (void)fy_getResource:(void (^)(UIView *bannerView))viewBlock
                   url:(void (^)(NSString *url))urlBlock;

@end
