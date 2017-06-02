//
//  WebController.m
//  MallO2O
//
//  Created by mac on 16/6/3.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "WebController.h"

@interface WebController ()<UIWebViewDelegate>

@property (strong ,nonatomic) UIWebView *webView;

@end

@implementation WebController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setBackButton];
    [self.view addSubview:self.webView];
    [_webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self setNavBarTitle:NSLocalizedString(@"orderNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    NSURL *url            = [NSURL URLWithString:self.model.url];
    NSLog(@"_________%@",self.model.url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];


}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initForAutoLayout];
        _webView.delegate = self;
    }
    return _webView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
