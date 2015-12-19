//
//  NSObject+FYKeyValue.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/14/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FYKeyValue <NSObject>

@optional

- (NSDictionary *)replacedKeyFromPropertyName;
- (NSDictionary *)objectClassInArray;
- (void)objectDidFinishConvertingToKeyValues;
- (void)keyValuesDidFinishConvertingToObject;

@end

@interface NSObject (FYKeyValue) <FYKeyValue>

+ (NSArray *)objectArrayWithFilename:(NSString *)filename;
+ (NSArray *)objectArrayWithFile:(NSString *)file;
+ (NSArray *)objectArrayWithKeyValuesArray:(NSArray *)keyValuesArray;
+ (instancetype)objectWithKeyValues:(NSDictionary *)keyValues;
- (void)setKeyValues:(NSDictionary *)keyValues;
- (NSDictionary *)keyValues;
+ (NSArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray;

@end
