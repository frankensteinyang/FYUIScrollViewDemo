//
//  FYAlertView.h
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FYAlertViewStyle) {
    FYAlertViewStyleNeutral = 0,
    FYAlertViewStyleInformation,
    FYAlertViewStyleSuccess,
    FYAlertViewStyleWarning,
    FYAlertViewStyleError
};

typedef NS_ENUM(NSUInteger, FYAlertViewButtonAlign) {
    FYAlertViewButtonAlignVertical = 0,
    FYAlertViewButtonAlignHorizontal
};

@interface FYAlertView : UIView

@property (nonatomic, strong) UIColor  *alertBackgroundColor
UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont   *titleFont
UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor  *messageColor
UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont   *messageFont
UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor  *buttonsTextColor
UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont   *buttonsFont
UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor  *separatorsLinesColor
UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont   *tapToCloseFont
UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor  *tapToCloseColor
UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSString *tapToCloseText
UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) BOOL                   tapToClose;
@property (assign, nonatomic) CGFloat                timeToClose;
@property (strong, nonatomic) NSString               *title;
@property (assign, nonatomic) FYAlertViewStyle       style;
@property (assign, nonatomic) FYAlertViewButtonAlign buttonAlign;
@property (strong, nonatomic) NSArray                *buttonsTexts;
@property (strong, nonatomic) NSString               *message;

- (void)setTitleColor:(UIColor *)color
    forAlertViewStyle:(FYAlertViewStyle)style UI_APPEARANCE_SELECTOR;
- (void)setDefaultTitle:(NSString *)defaultTitle
      forAlertViewStyle:(FYAlertViewStyle)style UI_APPEARANCE_SELECTOR;

+ (void)hideAll;

- (id)init;
- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message;
- (id)initWithTitle:(NSString *)title message:(NSString *)message
            buttons:(NSArray *)buttons
        andCallBack:(void (^)(FYAlertView *alertView,
                              NSInteger buttonIndex))callBackBlock;

- (void)show;
- (void)showAsMessage;
- (void)hide;

@end
