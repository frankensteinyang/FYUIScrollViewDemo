//
//  NSObject+FYEnumerater.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/14/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FYIvar.h"

typedef void (^FYClassesBlock)(Class c, BOOL *stop);

@interface NSObject (FYEnumerater)

// 遍历所有属性
- (void)enumerateIvarsWithBlock:(FYIvarsBlock)block;

- (void)enumerateClassesWithBlock:(FYClassesBlock)block;

@end
