//
//  OnlingViewController.m
//  MallO2O
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "OnlingViewController.h"

@interface OnlingViewController ()<UIWebViewDelegate>

@property (strong ,nonatomic) UIWebView *webView;

@end

@implementation OnlingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [_webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self setNavBarTitle:NSLocalizedString(@"mineOnline", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    NSURL *url            = [NSURL URLWithString:@"https://btrussia.kf5.com/kchat/19706?group=23521"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];

}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initForAutoLayout];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"swpNetworkToLoadDataTitle", nil) maskType:SVProgressHUDMaskTypeBlack];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [SVProgressHUD dismiss];
}

- (void)reloadWebView:(NSString *)urla{
    NSURL *url            = [NSURL URLWithString:urla];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}



@end
