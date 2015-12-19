//
//  FYEnumerater.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/15/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYEnumerater.h"
#import "FYDefine.h"
#import "FYFoundation.h"
#import "FYConverter.h"

@implementation FYEnumerater

- (instancetype)initWithSrcObject:(id)srcObject {
    if (self = [super init]) {
        _srcObject = srcObject;
    }
    return self;
}

- (void)setSrcClass:(Class)srcClass {
    _srcClass = srcClass;
    FYAssertParamNotNil(srcClass);
    _srcClassFromFoundation = [FYFoundation isClassFromFoundation:srcClass];
}

FYLogAllIvars

@end
