//
//  FYIvar.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/15/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYIvar.h"
#import "FYDefine.h"
#import "FYType.h"

@implementation FYIvar

- (instancetype)initWithIvar:(Ivar)ivar srcObject:(id)srcObject {
    if (self == [super initWithSrcObject:srcObject]) {
        self.ivar = ivar;
    }
    return self;
}

- (void)setIvar:(Ivar)ivar {
    _ivar = ivar;
    FYAssertParamNotNil(ivar);
    _name = [NSString stringWithUTF8String:ivar_getName(ivar)];
    
    if ([_name hasPrefix:@"_"]) {
        _propertyName = [_name stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                                       withString:@""];
    } else {
        _propertyName = _name;
    }
    NSString *code = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
    _type = [[FYType alloc] initWithCode:code];
}

- (id)value {
    if (_type.kvcDisabled) {
        return [NSNull null];
    }
    return [_srcObject valueForKey:_propertyName];
}

- (void)setValue:(id)value {
    if (_type.kvcDisabled) {
        return;
    }
    [_srcObject setValue:value forKey:_propertyName];
}

@end
