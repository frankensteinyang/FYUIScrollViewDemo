//
//  FYMedicalRecordViewController.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/26/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <libextobjc/EXTScope.h>

#import "FYMedicalRecordViewController.h"
#import "FYUIButton.h"

@implementation FYMedicalRecordViewController

// 身体状况记录，对自己负责
- (void)viewDidLoad {

    FYUIButton *backBtn = [[FYUIButton alloc] initWithFrame:CGRectZero
                                                      style:FYUIButtonStyleTranslucent];
    backBtn.text = @"Back to homepage";
    backBtn.font = [UIFont systemFontOfSize:14.0f];
    backBtn.vibrancyEffect = nil;
    [backBtn addTarget:self
                action:@selector(backBtnClicked)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    @weakify(self);
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(160, 40));
    }];
}

- (void)backBtnClicked {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end

// 界面视觉效果要震撼
