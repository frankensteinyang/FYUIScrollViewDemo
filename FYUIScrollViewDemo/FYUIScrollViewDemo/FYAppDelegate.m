//
//  FYAppDelegate.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYAppDelegate.h"
#import "FYUIViewController.h"

@interface FYAppDelegate ()

@end

@implementation FYAppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:
                   [[UIScreen mainScreen] bounds]];
    FYUIViewController *rootVC = [[FYUIViewController alloc] init];
    [self.window setRootViewController:rootVC];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
