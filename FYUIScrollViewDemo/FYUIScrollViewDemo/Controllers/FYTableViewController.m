//
//  FYTableViewController.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 12/2/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>

#import "FYTableViewController.h"
#import "FYUIButton.h"
#import "FYPullToRefreshModel.h"

#define kSCREEN_SIZE ([UIScreen mainScreen].bounds.size)

@interface FYTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *data;

@end

@implementation FYTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    FYUIButton *backBtn = [[FYUIButton alloc] initWithFrame:CGRectZero
                                                      style:FYUIButtonStyleTranslucent];
    backBtn.text = @"返回首页";
    backBtn.font = [UIFont systemFontOfSize:14.0f];
    backBtn.backgroundColor = [UIColor whiteColor];
    backBtn.vibrancyEffect = nil;
    [backBtn addTarget:self
                action:@selector(goToHomepageBtnClicked)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
    
    CGRect rect = CGRectMake(0, 100, kSCREEN_SIZE.width, kSCREEN_SIZE.height - 100);
    _tableView = [[UITableView alloc] initWithFrame:rect];
    [self.view addSubview:_tableView];
    
    @weakify(self);
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self.view.frame.origin.y + 50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(160, 40));
    }];
    
    _tableView.dataSource = self;
    
    // 下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_tableView.mj_header endRefreshing];
    }];
    
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉加载
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [_tableView.mj_footer endRefreshing];
    }];
    
}

- (NSArray *)data {
    if (!_data) {
        FYPullToRefreshModel *tableViewModel = [[FYPullToRefreshModel alloc] init];
        tableViewModel.header = @"下拉刷新";
        tableViewModel.viewControllerClass = [UITableViewController class];
        tableViewModel.titles = @[@"默认",
                                  @"动画",
                                  @"隐藏时间",
                                  @"隐藏状态和时间",
                                  @"自定义文字",
                                  @"自定义刷新控件"];
        
        tableViewModel.methods = @[@"000",
                                   @"001",
                                   @"002",
                                   @"003",
                                   @"004",
                                   @"005",
                                   @"006"];
        
        FYPullToRefreshModel *collectionModel = [[FYPullToRefreshModel alloc] init];
        collectionModel.header = @"上拉加载更多";
        collectionModel.viewControllerClass = [UICollectionViewController class];
        collectionModel.titles = @[@"默认",
                                   @"动画",
                                   @"隐藏时间",
                                   @"隐藏状态和时间",
                                   @"自定义文字",
                                   @"自定义刷新控件"];
        collectionModel.methods = @[@"000",
                                    @"001",
                                    @"002",
                                    @"003",
                                    @"004",
                                    @"005",
                                    @"006"];
        
        FYPullToRefreshModel *webViewModel = [[FYPullToRefreshModel alloc] init];
        webViewModel.header = @"下拉刷新";
        webViewModel.viewControllerClass = [UIViewController class];
        webViewModel.titles = @[@"默认",
                                @"动画",
                                @"隐藏时间",
                                @"隐藏状态和时间",
                                @"自定义文字",
                                @"自定义刷新控件"];
        webViewModel.methods = @[@"000",
                                 @"001",
                                 @"002",
                                 @"003",
                                 @"004",
                                 @"005",
                                 @"006"];
        
        self.data = @[tableViewModel, collectionModel, webViewModel];
    }
    return _data;
}

- (void)goToHomepageBtnClicked {
    [self dismissViewControllerAnimated:NO
                             completion:nil];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.data count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    FYPullToRefreshModel *refreshModel = self.data[section];
    return [refreshModel.titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"FYCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellID];
    }
    FYPullToRefreshModel *cellModel = self.data[indexPath.section];
    cell.textLabel.text = cellModel.titles[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", cellModel.viewControllerClass, cellModel.methods[indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    
    FYPullToRefreshModel *headerModel = self.data[section];
    return headerModel.header;
}

@end
