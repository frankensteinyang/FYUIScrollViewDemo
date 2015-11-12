//
//  FYUIButton.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYUIButton.h"

#define kFYUIButtonDefaultCornerRadius                 4.0
#define kFYUIButtonDefaultAlpha                        1.0
#define kFYUIButtonDefaultBorderWidth                  0.6
#define kFYUIButtonDefaultFontSize                     14.0
#define kFYUIButtonDefaultAlpha                        1.0
#define kFYUIButtonDefaultTranslucencyAlphaNormal      1.0
#define kFYUIButtonDefaultTranslucencyAlphaHighlighted 0.5

@interface FYUIButton () {

}

@property (nonatomic, assign) FYUIButtonStyle   style;
@property (nonatomic, strong) FYUIButtonOverlay *normalOverlay;
@property (nonatomic, assign) BOOL activeTouch;

@end

@implementation FYUIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame style:(FYUIButtonStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.style = style;
        self.userInteractionEnabled = YES;
        
        _cornerRadius = kFYUIButtonDefaultCornerRadius;
        _alpha = kFYUIButtonDefaultAlpha;
        _translucencyAlphaNormal = kFYUIButtonDefaultTranslucencyAlphaNormal;
        _translucencyAlphaHighlighted =
        kFYUIButtonDefaultTranslucencyAlphaHighlighted;
        _borderWidth = kFYUIButtonDefaultBorderWidth;
        _activeTouch = NO;
        
        [self createOverlays];
        
        [self addTarget:self action:@selector(touchDown) forControlEvents:
         UIControlEventTouchDown | UIControlEventTouchDragInside];
        [self addTarget:self action:@selector(touchUp) forControlEvents:
         UIControlEventTouchUpInside | UIControlEventTouchUpOutside |
         UIControlEventTouchDragOutside | UIControlEventTouchCancel];
    }
    return self;
}

- (void)createOverlays {
    if (self.style == FYUIButtonStyleTranslucent) {
        self.normalOverlay.alpha = self.translucencyAlphaNormal * self.alpha;
    }
}

#pragma mark - Control Event Handlers

- (void)touchDown {
    
    self.activeTouch = YES;
    
    void(^update)(void) = ^(void) {
        if (self.style == FYUIButtonStyleTranslucent) {
            self.normalOverlay.alpha = self.translucencyAlphaHighlighted * self.alpha;
        }
    };
    update();
}

- (void)touchUp {
    
    self.activeTouch = NO;
    
    void(^update)(void) = ^(void) {
        if (self.style == FYUIButtonStyleTranslucent) {
            self.normalOverlay.alpha = self.translucencyAlphaNormal * self.alpha;
        }
    };
    update();
}

@end
