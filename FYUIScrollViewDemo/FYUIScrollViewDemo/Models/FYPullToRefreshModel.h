//
//  FYPullToRefreshModel.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/4/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYPullToRefreshModel : NSObject

@property (nonatomic, copy  ) NSString *header;
@property (nonatomic, strong) NSArray  *titles;
@property (nonatomic, strong) NSArray  *methods;
@property (nonatomic, assign) Class    viewControllerClass;

@end
