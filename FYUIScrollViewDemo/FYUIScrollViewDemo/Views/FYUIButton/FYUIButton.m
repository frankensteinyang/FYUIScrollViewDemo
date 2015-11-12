//
//  FYUIButton.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYUIButton.h"
#import "FYDefine.h"

#define kFYUIButtonDefaultCornerRadius                 4.0
#define kFYUIButtonDefaultAlpha                        1.0
#define kFYUIButtonDefaultBorderWidth                  0.6
#define kFYUIButtonDefaultFontSize                     14.0
#define kFYUIButtonDefaultAlpha                        1.0
#define kFYUIButtonDefaultTranslucencyAlphaNormal      1.0
#define kFYUIButtonDefaultTranslucencyAlphaHighlighted 0.5
#define kFYUIButtonDefaultRoundingCorners              UIRectCornerAllCorners
#define kFYUIButtonDefaultBackgroundColor              [UIColor whiteColor]

@interface FYUIButton () {
    __strong UIColor *_backgroundColor;
}

@property (nonatomic, assign) FYUIButtonStyle    style;

#ifdef __IPHONE_8_0
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
#endif

@property (nonatomic, strong) FYUIButtonOverlay  *normalOverlay;
@property (nonatomic, strong) FYUIButtonOverlay  *highlightedOverlay;
@property (nonatomic, assign) BOOL               activeTouch;
@property (nonatomic, assign) BOOL               hideRightBorder;

- (void)createOverlays;

@end

/** FYUIButtonOverlay **/

@interface FYUIButtonOverlay () {
    __strong UIFont *_font;
    __strong UIColor *_backgroundColor;
}

@property (nonatomic, assign) FYUIButtonOverlayStyle style;
@property (nonatomic, assign) CGFloat                textHeight;
@property (nonatomic, assign) BOOL                   hideRightBorder;

- (void)_updateTextHeight;

@end

@implementation FYUIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    FYLog(@"FYUIButton must be initialized with initWithFrame:style:");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    FYLog(@"FYUIButton must be initialized with initWithFrame:style:");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame style:(FYUIButtonStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.style = style;
        self.opaque = NO;
        self.userInteractionEnabled = YES;
        
        _animated = YES;
        _cornerRadius = kFYUIButtonDefaultCornerRadius;
        _alpha = kFYUIButtonDefaultAlpha;
        _translucencyAlphaNormal = kFYUIButtonDefaultTranslucencyAlphaNormal;
        _translucencyAlphaHighlighted =
        kFYUIButtonDefaultTranslucencyAlphaHighlighted;
        _borderWidth = kFYUIButtonDefaultBorderWidth;
        _roundingCorners = kFYUIButtonDefaultRoundingCorners;
        _activeTouch = NO;
        
        [self createOverlays];
        
#ifdef __IPHONE_8_0
        // add the default vibrancy effect
        self.vibrancyEffect =
        [UIVibrancyEffect effectForBlurEffect:
         [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
#endif
        
        [self addTarget:self action:@selector(touchDown) forControlEvents:
         UIControlEventTouchDown | UIControlEventTouchDragInside];
        [self addTarget:self action:@selector(touchUp) forControlEvents:
         UIControlEventTouchUpInside | UIControlEventTouchUpOutside |
         UIControlEventTouchDragOutside | UIControlEventTouchCancel];
    }
    return self;
}

- (void)layoutSubviews {
#ifdef __IPHONE_8_0
    self.visualEffectView.frame = self.bounds;
#endif
    self.normalOverlay.frame = self.bounds;
    self.highlightedOverlay.frame = self.bounds;
}

- (void)createOverlays {
    self.normalOverlay =
    [[FYUIButtonOverlay alloc] initWithStyle:FYUIButtonOverlayStyleNormal];
    if (self.style == FYUIButtonStyleTranslucent) {
        self.normalOverlay.alpha = self.translucencyAlphaNormal * self.alpha;
    }
    
#ifndef __IPHONE_8_0
    /**
     *  for iOS 8, these two overlay views will be 
     *  added as subviews in setVibrancyEffect:
     */
    [self addSubview:self.normalOverlay];
    [self addSubview:self.highlightedOverlay];
#endif
    
}

#pragma mark - Control Event Handlers

- (void)touchDown {
    
    self.activeTouch = YES;
    
    void(^update)(void) = ^(void) {
        if (self.style == FYUIButtonStyleTranslucent) {
            self.normalOverlay.alpha =
            self.translucencyAlphaHighlighted * self.alpha;
        }
    };
    if (self.animated) {
        [UIView animateWithDuration:self.animationDuration animations:update];
    } else {
        update();
    }
}

- (void)touchUp {
    
    self.activeTouch = NO;
    
    void(^update)(void) = ^(void) {
        if (self.style == FYUIButtonStyleTranslucent) {
            self.normalOverlay.alpha =
            self.translucencyAlphaNormal * self.alpha;
        }
    };
    if (self.animated) {
        [UIView animateWithDuration:self.animationDuration animations:update];
    } else {
        update();
    }
}

#pragma mark - FYUIButton Override Getters

- (UIColor *)backgroundColor {
    return _backgroundColor =
    nil ? kFYUIButtonDefaultBackgroundColor : _backgroundColor;
}

#pragma mark - FYUIButton Override Setters

- (void)setAlpha:(CGFloat)alpha {
    _alpha = alpha;
    if (self.activeTouch) {
        if (self.style == FYUIButtonStyleTranslucent) {
            self.normalOverlay.alpha =
            self.translucencyAlphaHighlighted * self.alpha;
        }
    } else {
        if (self.style == FYUIButtonStyleTranslucent) {
            self.normalOverlay.alpha =
            self.translucencyAlphaNormal * self.alpha;
        }
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.normalOverlay.cornerRadius = cornerRadius;
    self.highlightedOverlay.cornerRadius = cornerRadius;
}

- (void)setRoundingCorners:(UIRectCorner)roundingCorners {
    _roundingCorners = roundingCorners;
    self.normalOverlay.roundingCorners = roundingCorners;
    self.highlightedOverlay.roundingCorners = roundingCorners;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.normalOverlay.borderWidth = borderWidth;
    self.highlightedOverlay.borderWidth = borderWidth;
}

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    self.normalOverlay.icon = icon;
    self.highlightedOverlay.icon = icon;
}

- (void)setText:(NSString *)text {
    _text = [text copy];
    self.normalOverlay.text = text;
    self.highlightedOverlay.text = text;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.normalOverlay.font = font;
    self.highlightedOverlay.font = font;
}

#ifdef __IPHONE_8_0
- (void)setVibrancyEffect:(UIVibrancyEffect *)vibrancyEffect {
    _vibrancyEffect = vibrancyEffect;
    [self.normalOverlay removeFromSuperview];
    [self.highlightedOverlay removeFromSuperview];
    [self.visualEffectView removeFromSuperview];
    
    if (vibrancyEffect != nil) {
        self.visualEffectView = [[UIVisualEffectView alloc]
                                 initWithEffect:vibrancyEffect];
        self.visualEffectView.userInteractionEnabled = NO;
        [self.visualEffectView.contentView addSubview:self.normalOverlay];
        [self.visualEffectView.contentView addSubview:self.highlightedOverlay];
        [self addSubview:self.visualEffectView];
    } else {
        [self addSubview:self.normalOverlay];
        [self addSubview:self.highlightedOverlay];
    }
}
#endif

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.normalOverlay.backgroundColor = backgroundColor;
    self.highlightedOverlay.backgroundColor = backgroundColor;
}

- (void)setHideRightBorder:(BOOL)hideRightBorder {
    _hideRightBorder = hideRightBorder;
    self.normalOverlay.hideRightBorder = hideRightBorder;
    self.highlightedOverlay.hideRightBorder = hideRightBorder;
}

@end

@implementation FYUIButtonOverlay

- (instancetype)initWithStyle:(FYUIButtonOverlayStyle)style {
    if (self = [self init]) {
        self.style = style;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _cornerRadius = kFYUIButtonDefaultCornerRadius;
        _borderWidth = kFYUIButtonDefaultBorderWidth;
        _roundingCorners = kFYUIButtonDefaultRoundingCorners;
        self.opaque = NO;
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGSize size = self.bounds.size;
    if (size.width == 0 || size.height == 0) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    [self.backgroundColor setStroke];
    [self.backgroundColor setFill];
    CGRect boxRect = CGRectInset(self.bounds,
                                 self.borderWidth / 2,
                                 self.borderWidth / 2);
    if (self.hideRightBorder) {
        boxRect.size.width += self.borderWidth * 2;
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:boxRect
                                               byRoundingCorners:
                          self.roundingCorners cornerRadii:
                          CGSizeMake(self.cornerRadius, self.cornerRadius)];
    path.lineWidth = self.borderWidth;
    [path stroke];
    CGContextClipToRect(context, boxRect);
    
    if (self.icon != nil) {
        CGSize iconSize = self.icon.size;
        CGRect iconRect = CGRectMake((size.width - iconSize.width) / 2,
                                     (size.height - iconSize.width) / 2,
                                     iconSize.width, iconSize.height);
        if (self.style == FYUIButtonOverlayStyleNormal) {
            // ref: http://blog.alanyip.me/tint-transparent-images-on-ios/
            CGContextSetBlendMode(context, kCGBlendModeNormal);
            CGContextFillRect(context, iconRect);
            CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
        }
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextDrawImage(context, iconRect, self.icon.CGImage);
    }
    if (self.text != nil) {
        NSMutableParagraphStyle *style =
        [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.lineBreakMode = NSLineBreakByTruncatingTail;
        style.alignment = NSTextAlignmentCenter;
        [self.text drawInRect:CGRectMake(0.0,
                                         (size.height - self.textHeight) / 2,
                                         size.width, self.textHeight)
               withAttributes:@{ NSFontAttributeName:self.font,
                                 NSForegroundColorAttributeName:
                                     self.backgroundColor,
                                 NSParagraphStyleAttributeName:style }];
    }
}

#pragma mark - FYUIButtonOverlay Override Getters

- (UIFont *)font {
    return _font ==
    nil ? [UIFont systemFontOfSize:kFYUIButtonDefaultFontSize] : _font;
}

- (UIColor *)backgroundColor {
    return _backgroundColor ==
    nil ? kFYUIButtonDefaultBackgroundColor : _backgroundColor;
}

#pragma mark - FYUIButtonOverlay Override Setters

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

- (void)setRoundingCorners:(UIRectCorner)roundingCorners {
    _roundingCorners = roundingCorners;
    [self setNeedsDisplay];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
}

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    _text = nil;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    _icon = nil;
    _text = [text copy];
    [self _updateTextHeight];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [self _updateTextHeight];
    [self setNeedsDisplay];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    [self setNeedsDisplay];
}

- (void)setHideRightBorder:(BOOL)hideRightBorder {
    _hideRightBorder = hideRightBorder;
    [self setNeedsDisplay];
}

#pragma mark - FYUIButtonOverlay Private Methods

- (void)_updateTextHeight {
    CGRect bounds = [self.text
                     boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                     options:NSStringDrawingUsesLineFragmentOrigin
                     attributes:@{ NSFontAttributeName:self.font }
                     context:nil];
    self.textHeight = bounds.size.height;
}

@end
