//
//  FYEnumerater.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/15/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYEnumerater : NSObject {

    __weak id _srcObject;
    NSString *_name;
}

@property (nonatomic, assign) Class srcClass;

@property (nonatomic,
           readonly,
           getter = isSrcClassFromFoundation) BOOL srcClassFromFoundation;
@property (nonatomic, weak, readonly) id srcObject;
@property (nonatomic, copy, readonly) NSString *name;

- (instancetype)initWithSrcObject:(id)srcObject;

@end
