//
//  FYStore.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/26/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYStore.h"
#import "FYConfigurationModel.h"

@implementation FYStore

static FYStore *SINGLETON = nil;

+ (FYStore *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SINGLETON = [[super allocWithZone:NULL] init];
    });
    return SINGLETON;
}

- (void)redirectURLWithContentID:(NSUInteger)contentID
                     redirectUrl:(NSString *)redirectUrl {
    if (!redirectUrl || (redirectUrl && ![redirectUrl length])) {
        return;
    }
    
}

@end
