//
//  FYConfigurationModel.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/27/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface FYConfigurationModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *play_duration;

@end
