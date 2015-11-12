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

@property (nonatomic, assign) BOOL         animated;
@property (nonatomic, assign) CGFloat      animationDuration;
@property (nonatomic, assign) CGFloat      cornerRadius;
@property (nonatomic, assign) CGFloat      alpha;
@property (nonatomic, assign) CGFloat      translucencyAlphaNormal;
@property (nonatomic, assign) CGFloat      translucencyAlphaHighlighted;
@property (nonatomic, assign) CGFloat      borderWidth;
@property (nonatomic, assign) UIRectCorner roundingCorners;
@property (nonatomic, strong) UIImage      *icon;
@property (nonatomic, copy  ) NSString     *text;
@property (nonatomic, strong) UIFont       *font;

#ifdef __IPHONE_8_0
// the vibrancy effect to be applied on the button
@property (nonatomic, strong) UIVibrancyEffect *vibrancyEffect;
#endif

// the background color when vibrancy effect is nil, or not supported.
@property (nonatomic, strong) UIColor *backgroundColor;

- (instancetype)initWithFrame:(CGRect)frame style:(FYUIButtonStyle)style;

@end

/** FYUIButtonOverlay **/

typedef enum {
    
    FYUIButtonOverlayStyleNormal
    
} FYUIButtonOverlayStyle;

@interface FYUIButtonOverlay : UIView

// numeric configurations
@property (nonatomic, assign) CGFloat      cornerRadius;
@property (nonatomic, assign) CGFloat      borderWidth;
@property (nonatomic, assign) UIRectCorner roundingCorners;

// icon image
@property (nonatomic, strong) UIImage      *icon;

// display text
@property (nonatomic, copy  ) NSString     *text;
@property (nonatomic, strong) UIFont       *font;
@property (nonatomic, strong) UIColor      *backgroundColor;

- (instancetype)initWithStyle:(FYUIButtonOverlayStyle)style;

@end
