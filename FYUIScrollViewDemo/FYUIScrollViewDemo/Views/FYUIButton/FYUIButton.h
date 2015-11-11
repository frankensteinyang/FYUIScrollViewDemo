//
//  FYUIButton.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    FYUIButtonStyleTranslucent
    
} FYUIButtonStyle;

@interface FYUIButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame style:(FYUIButtonStyle)style;

@end
