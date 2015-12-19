//
//  NSObject+FYEnumerater.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/14/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "NSObject+FYEnumerater.h"

@implementation NSObject (FYEnumerater)

- (void)enumerateIvarsWithBlock:(FYIvarsBlock)block {
    [self enumerateClassesWithBlock:^(__unsafe_unretained Class c, BOOL *stop) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        for (int i = 0; i < outCount; i ++) {
            FYIvar *ivar = [[FYIvar alloc] initWithIvar:ivars[i] srcObject:self];
            ivar.srcClass = c;
            block(ivar, stop);
        }
        free(ivars);
    }];
}

- (void)enumerateClassesWithBlock:(FYClassesBlock)block {
    if (block == nil) {
        return;
    }
    BOOL stop = NO;
    Class c = [self class];
    while (c && !stop) {
        block(c, &stop);
        c = class_getSuperclass(c);
    }
}

@end
