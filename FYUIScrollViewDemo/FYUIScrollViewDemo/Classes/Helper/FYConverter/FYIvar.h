//
//  FYIvar.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/15/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <objc/runtime.h>

#import "FYEnumerater.h"

@class FYType;

@interface FYIvar : FYEnumerater

@property (nonatomic, assign) Ivar ivar;
@property (nonatomic, copy, readonly) NSString *propertyName;
@property (nonatomic) id value;
@property (nonatomic, strong, readonly) FYType *type;

- (instancetype)initWithIvar:(Ivar)ivar srcObject:(id)srcObject;

@end

typedef void (^FYIvarsBlock)(FYIvar *ivar, BOOL *stop);