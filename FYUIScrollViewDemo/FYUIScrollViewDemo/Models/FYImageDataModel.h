//
//  FYImageDataModel.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/24/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FYImageDataModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *image;
@property (nonatomic, copy) NSString <Optional> *url;
@property (nonatomic, copy) NSString <Optional> *contentID;

@end
