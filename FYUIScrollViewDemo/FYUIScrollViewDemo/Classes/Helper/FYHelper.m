//
//  FYHelper.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/25/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/SDWebImageDownloader.h>

#import "FYHelper.h"

@implementation FYHelper

+ (void)downloadImageWithUrl:(NSString *)url relatedLink:(NSString *)relatedLink downloadImageCallBack:(void (^)(UIImage *, NSString *))block {
    if ([url isKindOfClass:[NSString class]] && [url length]) {
        [[SDImageCache sharedImageCache] queryDiskCacheForKey:url done:^(UIImage *image, SDImageCacheType cacheType) {
            if (!image) {
                [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageProgressiveDownload progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if (finished) {
                        [[SDWebImageManager sharedManager] saveImageToCache:image forURL:[NSURL URLWithString:url]];
                        if (block) {
                            block(image, relatedLink ?: @"");
                        }
                    }
                }];
            } else {
                if (block) {
                    block(image, relatedLink ?: @"");
                }
            }
        }];
    }
}

@end
