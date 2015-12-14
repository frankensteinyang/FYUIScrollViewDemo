//
//  NSObject+FYKeyValue.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/14/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "NSObject+FYKeyValue.h"
#import "FYDefine.h"

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

@end
