//
//  FYWebViewController.m
//  FYUIScrollViewDemo
//
//  Created by Frankenstein Yang on 11/23/15.
//  Copyright © 2015 Frankenstein Yang. All rights reserved.
//

#import "FYWebViewController.h"
#import "FYUIButton.h"
#import "FYDefine.h"

@interface FYWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation FYWebViewController

- (void)dealloc {
    if ([self.webView isLoading]) {
        [self.webView stopLoading];
    }
    self.webView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    FYUIButton *backBtn = [[FYUIButton alloc] initWithFrame:CGRectZero
                                                      style:FYUIButtonStyleTranslucent];
    backBtn.text = @"Back";
    backBtn.font = [UIFont systemFontOfSize:14.0f];
    backBtn.vibrancyEffect = nil;
    [backBtn addTarget:self action:@selector(backBtnClicked)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
}

- (void)setUrl:(NSString *)url {
    if (!url) {
        return;
    }
    NSString *encodedString =
    [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_webView loadRequest:[NSURLRequest
                           requestWithURL:[NSURL URLWithString:encodedString]
                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                           timeoutInterval:30]];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:
                    CGRectMake(0, 0,
                               [UIScreen mainScreen].bounds.size.width,
                               [UIScreen mainScreen].bounds.size.height)];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
    }
    return _webView;
}

- (void)backBtnClicked {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    FYLog(@"%@", request.URL.absoluteString);
    return YES;
    
}

@end
