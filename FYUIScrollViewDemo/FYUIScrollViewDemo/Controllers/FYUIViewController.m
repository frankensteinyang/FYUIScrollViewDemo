//
//  FYUIViewController.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYUIViewController.h"
#import "FYUIButton.h"
#import "FYAlertView.h"
#import "FYPublicService.h"

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
    showBannerBtn.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:
                                    [UIBlurEffect effectWithStyle:
                                     UIBlurEffectStyleExtraLight]];
    [showBannerBtn addTarget:self action:@selector(showBannerBtnClicked)
            forControlEvents:UIControlEventTouchUpInside];
    [effectView.contentView addSubview:showBannerBtn];
    
    FYUIButton *showAlertBtn = [[FYUIButton alloc]
                                 initWithFrame:CGRectZero
                                 style:FYUIButtonStyleTranslucent];
    showAlertBtn.text = @"Alert";
    showAlertBtn.font = [UIFont systemFontOfSize:14.0];
    showAlertBtn.backgroundColor = [UIColor whiteColor];
    showAlertBtn.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:
                                    [UIBlurEffect effectWithStyle:
                                     UIBlurEffectStyleExtraLight]];
    [showAlertBtn addTarget:self action:@selector(showAlertBtnClicked)
            forControlEvents:UIControlEventTouchUpInside];
    [effectView.contentView addSubview:showAlertBtn];
    
    @weakify(self);
    [showBannerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(self.view.frame.origin.x + 10);
        make.top.mas_equalTo(self.view.frame.origin.y + 10);
        make.size.mas_equalTo(CGSizeMake(160, 40));
    }];
    [showAlertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(self.view.frame.origin.x + 180);
        make.top.mas_equalTo(self.view.frame.origin.y + 10);
        make.size.mas_equalTo(CGSizeMake(160, 40));
    }];
}

- (void)showBannerBtnClicked {
    
    @weakify(self);
    [FYPublicService fy_getResource:^(UIView *bannerView) {
        @strongify(self);
        if (bannerView) {
            bannerView.frame = CGRectMake(40, [UIScreen mainScreen].bounds.size.height - 60, [UIScreen mainScreen].bounds.size.width - 80, 40);
            bannerView.tag = 168;
            [self.view addSubview:bannerView];
        }
    } url:^(NSString *url) {
//        @strongify(self);
        //
//        [self presentViewController:nil animated:NO completion:nil];
    }];
}

- (void)showAlertBtnClicked {

    FYAlertView *alert = [[FYAlertView alloc] initWithTitle:@"弹框" andMessage:@"很酷的提示框！"];
    [alert show];
}

@end
