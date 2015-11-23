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
#import "FYDefine.h"
#import "FYWebViewController.h"

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
    showBannerBtn.font = [UIFont systemFontOfSize:14.0f];
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
    showAlertBtn.font = [UIFont systemFontOfSize:14.0f];
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
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.frame.origin.y + 40);
        make.size.mas_equalTo(CGSizeMake(160, 40));
    }];
    [showAlertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(showBannerBtn.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(160, 40));
    }];
}

- (void)showBannerBtnClicked {
    
    @weakify(self);
    [FYPublicService fy_getResource:^(UIView *bannerView) {
        @strongify(self);
        if (bannerView) {
            bannerView.frame =
            CGRectMake(40, [UIScreen mainScreen].bounds.size.height -
                       60, [UIScreen mainScreen].bounds.size.width - 80, 40);
            bannerView.tag = 168;
            [self.view addSubview:bannerView];
        }
    } url:^(NSString *url) {
        FYLog(@"%@", url);
        @strongify(self);
        FYWebViewController *webVC = [[FYWebViewController alloc] init];
        [self presentViewController:webVC animated:NO completion:nil];
        webVC.url = url;
    }];
}

- (void)showAlertBtnClicked {

    FYAlertView *alert = [[FYAlertView alloc] initWithTitle:@"弹框"
                                                 andMessage:@"很酷的提示框！"];
    [alert show];
}

@end
