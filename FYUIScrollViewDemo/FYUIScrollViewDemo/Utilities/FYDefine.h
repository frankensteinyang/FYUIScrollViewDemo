//
//  FYDefine.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/12/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#ifndef FYDefine_h
#define FYDefine_h

#ifdef DEBUG
#   define FYLog(fmt, ...) NSLog((@"%s [Line %d]" fmt), \
__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define FYLog(...)
#endif

#endif /* FYDefine_h */
