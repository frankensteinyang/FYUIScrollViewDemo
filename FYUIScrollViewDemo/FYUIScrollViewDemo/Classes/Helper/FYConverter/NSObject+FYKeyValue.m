//
//  NSObject+FYKeyValue.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/14/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "NSObject+FYKeyValue.h"
#import "FYDefine.h"
#import "NSObject+FYEnumerater.h"
#import "FYType.h"

@implementation NSObject (FYKeyValue)

+ (NSArray *)objectArrayWithFilename:(NSString *)filename {
    FYAssertParamNotNil(filename);
    NSString *file = [[NSBundle mainBundle] pathForResource:filename
                                                     ofType:nil];
    return [self objectArrayWithFile:file];
}

+ (NSArray *)objectArrayWithFile:(NSString *)file {
    FYAssertParamNotNil(file);
    NSArray *keyValuesArray = [NSArray arrayWithContentsOfFile:file];
    return [self objectArrayWithKeyValuesArray:keyValuesArray];
}

+ (NSArray *)objectArrayWithKeyValuesArray:(NSArray *)keyValuesArray {
    NSString *desc = [NSString stringWithFormat:@"keyValuesArray is a %@",
                      keyValuesArray.class];
    FYAssert([keyValuesArray isKindOfClass:[NSArray class]], desc);
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *keyValues in keyValuesArray) {
        if (![keyValues isKindOfClass:[NSDictionary class]]) continue;
//        id model = [self ]
        
    }
    return modelArray;
}

+ (instancetype)objectWithKeyValues:(NSDictionary *)keyValues {
    NSString *desc = [NSString stringWithFormat:@"keyValues is a %@",
                      keyValues.class];
    FYAssert([keyValues isKindOfClass:[NSDictionary class]], desc);
    id model = [[self alloc] init];
//    [model setkeyval]
    return model;
}

- (void)setKeyValues:(NSDictionary *)keyValues {
    NSString *desc = [NSString stringWithFormat:@"keyValues is a %@",
                      keyValues.class];
    FYAssert([keyValues isKindOfClass:[NSDictionary class]], desc);
//    [self e]
}

- (NSDictionary *)keyValues {
    NSMutableDictionary *keyValues = [NSMutableDictionary dictionary];
    [self enumerateIvarsWithBlock:^(FYIvar *ivar, BOOL *stop) {
        if (ivar.isSrcClassFromFoundation) return;
        id value = ivar.value;
        if (ivar.type.typeClass && !ivar.type.isFromFoundation) {
            value = [value keyValues];
        } else if ([self respondsToSelector:@selector(objectClassInArray)]) {
            Class objectClass = self.objectClassInArray[ivar.propertyName];
            if (objectClass) {
                value = [objectClass keyValuesArrayWithObjectArray:value];
            }
        }
        NSString *key = [self keyWithPropertyName:ivar.propertyName];
        keyValues[key] = value;
    }];
    if ([self respondsToSelector:@selector(objectDidFinishConvertingToKeyValues)]) {
        [self objectDidFinishConvertingToKeyValues];
    }
    return keyValues;
}

+ (NSArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray {
    NSString *desc = [NSString stringWithFormat:@"objectArray is a %@",
                      objectArray.class];
    FYAssert([objectArray isKindOfClass:[NSArray class]], desc);
    if (![objectArray isKindOfClass:[NSArray class]]) {
        return objectArray;
    }
    if (![[objectArray lastObject] isKindOfClass:self]) {
        return objectArray;
    }
    NSMutableArray *keyValuesArray = [NSMutableArray array];
    for (id object in objectArray) {
        [keyValuesArray addObject:[object keyValues]];
    }
    return keyValuesArray;
}

#pragma mark - Private Methods

- (NSString *)keyWithPropertyName:(NSString *)propertyName {
    FYAssertParamNotNil(propertyName);
    NSString *key = nil;
    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        key = self.replacedKeyFromPropertyName[propertyName];
    }
    if (!key) {
        key = propertyName;
    }
    return key;
}

@end
