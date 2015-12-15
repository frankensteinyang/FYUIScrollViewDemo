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

- (void)enumerateIvarsWithBlock:(FYIvarsBlock)block;

@end
