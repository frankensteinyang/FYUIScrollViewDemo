//
//  FYConverter.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/15/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "NSObject+FYKeyValue.h"
#import "NSObject+FYEnumerater.h"
#import "FYTypeEncoding.h"

#ifndef FYConverter_h

#define FYLogAllIvars \
- (NSString *)description { \
return [self keyValues].description; \
}

#endif /* FYConverter_h */


