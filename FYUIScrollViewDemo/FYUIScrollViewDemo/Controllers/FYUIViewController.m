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
    
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    @weakify(self);
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(160, 40));
    }];
    
    FYUIButton *showBannerBtn = [[FYUIButton alloc]
                                 initWithFrame:CGRectMake(0, 0, 160, 40)
                                 style:FYUIButtonStyleTranslucent];
    showBannerBtn.text = @"Banner";
    showBannerBtn.font = [UIFont systemFontOfSize:14.0];
    showBannerBtn.backgroundColor = [UIColor whiteColor];
    [showBannerBtn addTarget:self action:@selector(showBannerBtnClicked)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBannerBtn];
}

- (void)showBannerBtnClicked {
    
}

@end
