//
//  FYType.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/15/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYType : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign, readonly) Class typeClass;
@property (nonatomic, readonly, getter = isFromFoundation) BOOL fromFoundation;
@property (nonatomic, readonly, getter = isKVCDisabled) BOOL kvcDisabled;

- (instancetype)initWithCode:(NSString *)code;

@end
