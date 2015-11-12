//
//  FYAlertView.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FYAlertViewStyle) {
    TAlertViewStyleNeutral = 0
};

@interface FYAlertView : UIView

@property (strong, nonatomic) NSString *message;
@property (assign, nonatomic) FYAlertViewStyle style;

-(id)init;

-(void)show;
-(void)hide;

@end
