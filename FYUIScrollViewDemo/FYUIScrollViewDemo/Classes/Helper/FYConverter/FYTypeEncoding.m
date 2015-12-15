//
//  FYTypeEncoding.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/15/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYTypeEncoding.h"

// 属性类型
NSString *const FYTypeInt = @"i";
NSString *const FYTypeFloat = @"f";
NSString *const FYTypeDouble = @"d";
NSString *const FYTypeLong = @"q";
NSString *const FYTypeLongLong = @"q";
NSString *const FYTypeChar = @"c";
NSString *const FYTypeBOOL = @"c";
NSString *const FYTypePointer = @"*";

NSString *const FYTypeIvar = @"^{objc_ivar=}";
NSString *const FYTypeMethod = @"^{objc_method=}";
NSString *const FYTypeBlock = @"@?";
NSString *const FYTypeClass = @"#";
NSString *const FYTypeSEL = @":";
NSString *const FYTypeId = @"@";

// 返回值类型
NSString *const FYReturnTypeVoid = @"v";
NSString *const FYReturnTypeObject = @"@";

@implementation FYTypeEncoding

@end
