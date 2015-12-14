//
//  NSObject+FYKeyValue.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/14/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FYKeyValue)

+ (NSArray *)objectArrayWithFilename:(NSString *)filename;
+ (NSArray *)objectArrayWithFile:(NSString *)file;
+ (NSArray *)objectArrayWithKeyValuesArray:(NSArray *)keyValuesArray;
+ (instancetype)objectWithKeyValues:(NSDictionary *)keyValues;
- (void)setKeyValues:(NSDictionary *)keyValues;

@end
