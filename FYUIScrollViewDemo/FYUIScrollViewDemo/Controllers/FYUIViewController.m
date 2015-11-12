//
//  FYUIViewController.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYUIViewController.h"
#import "FYUIButton.h"

#import <libextobjc/EXTScope.h>
#import <Masonry/Masonry.h>

@implementation FYUIViewController

- (void)viewDidLoad {
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]
                                      initWithEffect:
                                      [UIBlurEffect effectWithStyle:
                                       UIBlurEffectStyleExtraLight]];
    effectView.frame = self.view.bounds;
    effectView.backgroundColor = [UIColor redColor];
    [self.view addSubview:effectView];
    
    FYUIButton *showBannerBtn = [[FYUIButton alloc]
                                 initWithFrame:CGRectZero
                                 style:FYUIButtonStyleTranslucent];
    showBannerBtn.text = @"Banner";
    showBannerBtn.font = [UIFont systemFontOfSize:14.0];
    showBannerBtn.backgroundColor = [UIColor whiteColor];
//    showBannerBtn.vibrancyEffect = nil;
    showBannerBtn.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:
                                    [UIBlurEffect effectWithStyle:
                                     UIBlurEffectStyleExtraLight]];
    [showBannerBtn addTarget:self action:@selector(showBannerBtnClicked)
            forControlEvents:UIControlEventTouchUpInside];
    [effectView.contentView addSubview:showBannerBtn];
    
    @weakify(self);
    [showBannerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(160, 40));
    }];
}

- (void)showBannerBtnClicked {
    
}

@end
