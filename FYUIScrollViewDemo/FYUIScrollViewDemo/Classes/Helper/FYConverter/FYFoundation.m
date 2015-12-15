//
//  FYFoundation.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/15/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYFoundation.h"
#import "FYDefine.h"

static NSArray *_foundationClasses;

@implementation FYFoundation

+ (void)initialize {
    _foundationClasses = @[@"NSArray", @"NSAutoreleasePool", @"NSBundle",
                           @"NSByteOrder", @"NSCalendar", @"NSCharacterSet",
                           @"NSCoder", @"NSData", @"NSDate", @"NSDateFormatter",
                           @"NSDecimal", @"NSDecimalNumber", @"NSDictionary",
                           @"NSEnumerator", @"NSError", @"NSException",
                           @"NSFileHandle", @"NSFileManager", @"NSFormatter",
                           @"NSHashTable", @"NSHTTPCookie",
                           @"NSHTTPCookieStorage", @"NSIndexPath",
                           @"NSIndexSet", @"NSInvocation",
                           @"NSJSONSerialization", @"NSKeyValueCoding",
                           @"NSKeyValueObserving", @"NSKeyedArchiver",
                           @"NSLocale",@"NSLock", @"NSMapTable",
                           @"NSMethodSignature", @"NSNotification",
                           @"NSNotificationQueue", @"NSNull",
                           @"NSNumberFormatter", @"NSObject", @"NSOperation",
                           @"NSOrderedSet", @"NSOrthography",
                           @"NSPathUtilities", @"NSPointerArray",
                           @"NSPointerFunctions", @"NSPort", @"NSProcessInfo",
                           @"NSPropertyList", @"NSProxy", @"NSRange",
                           @"NSRegularExpression", @"NSRunLoop", @"NSScanner",
                           @"NSSet", @"NSSortDescriptor", @"NSStream",
                           @"NSString", @"NSTextCheckingResult", @"NSThread",
                           @"NSTimeZone", @"NSTimer", @"NSURL",
                           @"NSURLAuthenticationChallenge", @"NSURLCache",
                           @"NSURLConnection", @"NSURLCredential",
                           @"NSURLCredentialStorage", @"NSURLError",
                           @"NSURLProtectionSpace", @"NSURLProtocol",
                           @"NSURLRequest", @"NSURLResponse", @"NSUserDefaults",
                           @"NSValue", @"NSValueTransformer", @"NSXMLParser",
                           @"NSZone"];
}

+ (BOOL)isClassFromFoundation:(Class)c {
    FYAssertParamNotNil(c);
    return [_foundationClasses containsObject:NSStringFromClass(c)];
}

@end
