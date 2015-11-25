//
//  FYHelper.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/25/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FYHelper : NSObject

+ (void)downloadImageWithUrl:(NSString *)url relatedLink:(NSString *)relatedLink downloadImageCallBack:(void (^)(UIImage *image, NSString *link))block;

@end
