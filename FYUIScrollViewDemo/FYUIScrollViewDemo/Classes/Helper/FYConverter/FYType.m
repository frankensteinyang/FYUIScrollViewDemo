//
//  FYType.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/15/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYType.h"
#import "FYDefine.h"
#import "FYTypeEncoding.h"
#import "FYFoundation.h"
#import "FYConverter.h"

@implementation FYType

- (instancetype)initWithCode:(NSString *)code {
    if (self = [super init]) {
        self.code = code;
    }
    return self;
}

- (void)setCode:(NSString *)code {
    
    _code = code;
    FYAssertParamNotNil(code);
    if (code.length == 0 ||
        [code isEqualToString:FYTypeSEL] ||
        [code isEqualToString:FYTypeIvar] ||
        [code isEqualToString:FYTypeMethod]) {
        
        _kvcDisabled = YES;
        
    } else if ([code hasPrefix:@"@"] && code.length > 3) {
        
        _code = [code substringFromIndex:2];
        _code = [_code substringToIndex:_code.length - 1];
        _typeClass = NSClassFromString(_code);
        _fromFoundation = [FYFoundation isClassFromFoundation:_typeClass];
        
    }
}

FYLogAllIvars

@end
