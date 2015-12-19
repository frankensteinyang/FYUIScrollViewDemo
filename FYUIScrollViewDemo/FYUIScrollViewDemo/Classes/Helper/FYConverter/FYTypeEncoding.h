//
//  FYTypeEncoding.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/15/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

// 属性类型
extern NSString *const FYTypeInt;
extern NSString *const FYTypeFloat;
extern NSString *const FYTypeDouble;
extern NSString *const FYTypeLong;
extern NSString *const FYTypeLongLong;
extern NSString *const FYTypeChar;
extern NSString *const FYTypeBOOL;
extern NSString *const FYTypePointer;

extern NSString *const FYTypeIvar;
extern NSString *const FYTypeMethod;
extern NSString *const FYTypeBlock;
extern NSString *const FYTypeClass;
extern NSString *const FYTypeSEL;
extern NSString *const FYTypeId;

// 返回值类型
extern NSString *const FYReturnTypeVoid;
extern NSString *const FYReturnTypeObject;

@interface FYTypeEncoding : NSObject

@end
