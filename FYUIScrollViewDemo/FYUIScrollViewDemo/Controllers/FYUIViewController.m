//
//  FYUIViewController.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/11/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <Masonry/Masonry.h>

#import "FYUIViewController.h"
#import "FYUIButton.h"
#import "FYAlertView.h"
#import "FYPublicService.h"
#import "FYDefine.h"
#import "FYWebViewController.h"
#import "FYTableViewController.h"

@interface FYUIViewController ()

@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation FYUIViewController

- (void)viewDidLoad {
    
    [self.view addSubview:self.effectView];
    FYUIButton *showBannerBtn = [[FYUIButton alloc] initWithFrame:CGRectZero
                                                            style:FYUIButtonStyleTranslucent];
    showBannerBtn.text = @"广告";
    showBannerBtn.font = [UIFont systemFontOfSize:14.0f];
    showBannerBtn.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [showBannerBtn addTarget:self
                      action:@selector(showBannerBtnClicked)
            forControlEvents:UIControlEventTouchUpInside];
    [_effectView.contentView addSubview:showBannerBtn];
    
    FYUIButton *showAlertBtn = [[FYUIButton alloc] initWithFrame:CGRectZero
                                                           style:FYUIButtonStyleTranslucent];
    showAlertBtn.text = @"提示框";
    showAlertBtn.font = [UIFont systemFontOfSize:14.0f];
    showAlertBtn.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [showAlertBtn addTarget:self
                     action:@selector(showAlertBtnClicked)
           forControlEvents:UIControlEventTouchUpInside];
    [_effectView.contentView addSubview:showAlertBtn];
    
    FYUIButton *pullToRefreshBtn = [[FYUIButton alloc] initWithFrame:CGRectZero
                                                               style:FYUIButtonStyleTranslucent];
    pullToRefreshBtn.text = @"下拉刷新";
    pullToRefreshBtn.font = [UIFont systemFontOfSize:14.0f];
    pullToRefreshBtn.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [pullToRefreshBtn addTarget:self
                         action:@selector(pullToRefreshBtnClicked)
               forControlEvents:UIControlEventTouchUpInside];
    [_effectView.contentView addSubview:pullToRefreshBtn];
    
    FYUIButton *waterfallBtn = [[FYUIButton alloc] initWithFrame:CGRectZero
                                                           style:FYUIButtonStyleTranslucent];
    waterfallBtn.text = @"瀑布流布局";
    waterfallBtn.font = [UIFont systemFontOfSize:14.0f];
    waterfallBtn.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [waterfallBtn addTarget:self
                     action:@selector(waterfallBtnClicked)
           forControlEvents:UIControlEventTouchUpInside];
    [_effectView.contentView addSubview:waterfallBtn];
    
    @weakify(self);
    [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view).with.insets
        (UIEdgeInsetsMake(20.0f, 20.0f, 20.0f, 20.0f));
    }];
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
    [pullToRefreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(showAlertBtn.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(160, 40));
    }];
    [waterfallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(pullToRefreshBtn.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(160, 40));
    }];
}

#ifdef DEBUG
    // TEST
#endif

- (void)showBannerBtnClicked {
    
    [[_effectView viewWithTag:168] removeFromSuperview];
    @weakify(self);
    [FYPublicService fy_getResource:^(UIView *bannerView) {
        @strongify(self);
        if (bannerView) {
            
            bannerView.frame = CGRectZero;
            bannerView.tag = 168;
            [self.effectView addSubview:bannerView];
            
            [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(_effectView.frame.size.height - 50);
                make.size.mas_equalTo
                (CGSizeMake(_effectView.frame.size.width, 50));
            }];
            
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

- (void)pullToRefreshBtnClicked {
    FYTableViewController *tableVC = [[FYTableViewController alloc] init];
    [self presentViewController:tableVC animated:NO completion:nil];
}

- (void)waterfallBtnClicked {

}

#pragma mark - 懒加载

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        _effectView =
        [[UIVisualEffectView alloc] initWithEffect:
         [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        [_effectView setBackgroundColor:[UIColor redColor]];
    }
    return _effectView;
}

@end
