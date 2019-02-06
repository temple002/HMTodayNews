//
//  HMTopicDetailViewController.m
//  主流框架
//
//  Created by WYSD-YTJ-010 on 2017/11/21.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMTopicDetailViewController.h"
#import "AppDelegate.h"

@interface HMTopicDetailViewController ()

@property (nonatomic, strong) UIWebView *webview;

@end

@implementation HMTopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webview];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.tabVC hideTabView];
}

- (void)setDisplayUrl:(NSString *)displayUrl {
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:displayUrl]]];
}

- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _webview.backgroundColor = [UIColor whiteColor];
    }
    return _webview;
}

@end
