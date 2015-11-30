//
//  FYStore.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/26/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FYConfigurationModel;

@interface FYStore : NSObject

@property (nonatomic, strong) FYConfigurationModel *configModel;

+ (FYStore *)sharedInstance;

- (void)redirectURLWithContentID:(NSUInteger)contentID
                     redirectUrl:(NSString *)redirectUrl;

@end
