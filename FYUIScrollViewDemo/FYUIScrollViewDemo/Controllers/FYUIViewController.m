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
//    FYAlertView *alert = [[FYAlertView alloc] initWithTitle:@"弹框"
//                                                 andMessage:@"很酷的提示框！"];
//    [alert show];
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

@end
