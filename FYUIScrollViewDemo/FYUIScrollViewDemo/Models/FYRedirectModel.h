//
//  FYRedirectModel.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/27/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface FYRedirectModel : NSObject

@end

@interface FYRedirectParams : JSONModel

@property (nonatomic, copy) NSNumber <Optional> *contentID;
@property (nonatomic, copy) NSString *redirectUrl;

@end
