//
//  FYHelper.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/25/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FY_Environment_Type) {
    FY_Environment_Type_Production = 0,
    FY_Environment_Type_Test,
    FY_Environment_Type_Dev
};

@interface FYHelper : NSObject

+ (void)downloadImageWithUrl:(NSString *)url
                 relatedLink:(NSString *)relatedLink
       downloadImageCallBack:(void (^)(UIImage *image, NSString *link))block;

@end
