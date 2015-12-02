//
//  FYTableViewController.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/2/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <Masonry/Masonry.h>

#import "FYTableViewController.h"
#import "FYUIButton.h"

#define kSCREEN_SIZE ([UIScreen mainScreen].bounds.size)

@implementation FYTableViewController

- (void)viewDidLoad {
    FYUIButton *backBtn = [[FYUIButton alloc] initWithFrame:CGRectZero style:FYUIButtonStyleTranslucent];
    backBtn.text = @"返回首页";
    backBtn.font = [UIFont systemFontOfSize:14.0f];
    backBtn.backgroundColor = [UIColor whiteColor];
    backBtn.vibrancyEffect = nil;
//    backBtn.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [backBtn addTarget:self action:@selector(goToHomepageBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, kSCREEN_SIZE.width, kSCREEN_SIZE.height - 100)];
    [self.view addSubview:tableView];
    
    @weakify(self);
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self.view.frame.origin.y + 50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(160, 40));
    }];
}

- (void)goToHomepageBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 10;
//}

@end
