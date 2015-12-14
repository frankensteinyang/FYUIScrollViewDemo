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

#pragma mark - iOS系统版本判断
#define kFYIOS7_OR_LATER \
([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != \
NSOrderedAscending)

#pragma mark - 断言
#define FYAssert(condition, desc) \
NSAssert(condition, @"\n报错文件：%@\n报错行数：第%d行\n报错方法：%s\n错误描述：%@", \
[NSString stringWithUTF8String:__FILE__], __LINE__,  __FUNCTION__, desc)

#define FYAssertParamNotNil(param) \
FYAssert(param, [[NSString stringWithFormat:@#param] \
stringByAppendingString:@"参数不能为nil"])

#endif /* FYDefine_h */
