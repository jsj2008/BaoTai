//
//  WebDestineViewController.m
//  MallO2O
//
//  Created by mac on 16/5/27.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "WebDestineViewController.h"
#import "ChooseViewController.h"
#import "SucceedViewController.h"
#import <WebViewJavascriptBridge.h>
@interface WebDestineViewController ()<UIWebViewDelegate>

@property (strong ,nonatomic) UIWebView *webView;
@property (strong ,nonatomic) WebViewJavascriptBridge *bridge;


@end

@implementation WebDestineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [WebViewJavascriptBridge enableLogging];
    
    [self setBridgeMutual];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self postRequst];
    
}

- (void)setBridgeMutual{
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    __weak typeof(self) selfVC = self;
    [self.bridge registerHandler:@"tz" handler:^(id data, WVJBResponseCallback responseCallback) {
#warning 跳转添加乘客界面
        
        ChooseViewController *vc = [[ChooseViewController alloc] init];
        [vc popViewControllerArray:^(NSArray *array) {
           
            selfVC.p_idArray = array;
            
        }];
        
        [selfVC.navigationController pushViewController:vc animated:YES];
        
    }];
    
    [self.bridge registerHandler:@"reserve_insert" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:data];
        
        
        NSString *url = [SwpTools swpToolGetInterfaceURL:@"reserve_insert"]; //192.168.1.66/baotaiapp_action/ac_reserve/reserve_insert
        if (url != nil) {
            [dic setValue:url forKey:@"app_key"];
        }
        NSString *str = [dic objectForKey:@"voucher"];
        [dic removeObjectForKey:@"voucher"];
        [dic setValue:str forKey:@"document"];
        
        NSString *str1 = [dic objectForKey:@"origin_id"];
        [dic removeObjectForKey:@"origin_id"];
        [dic setValue:str1 forKey:@"origin"];
        
        NSString *str2 = [dic objectForKey:@"destination_id"];
        [dic removeObjectForKey:@"destination_id"];
        [dic setValue:str2 forKey:@"destination"];
        
        NSString *str3 = [dic objectForKey:@"p_id"];
        [dic removeObjectForKey:@"p_id"];
        [dic setValue:str3 forKey:@"passenger"];
        
        [SwpRequest swpPOST:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
            if ([resultObject[@"code"] integerValue] == 200) {
                
                SucceedViewController *vc = [[SucceedViewController alloc] init];
                [selfVC.navigationController pushViewController:vc animated:YES];
                

            }
            
            
        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            
        }];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI{
    [self.view addSubview:self.webView];
    [_webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self setNavBarTitle:NSLocalizedString(@"destineViewNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    

}

- (void)postRequst {
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/app_action/ac_reserve/train_reserve",baseUrl];
    
    if (self.p_idArray.count == 0) {
        
        NSURL *url            = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";//设置请求方法
        request.HTTPBody = [self.body dataUsingEncoding:NSUTF8StringEncoding];
        [_webView loadRequest:request];
    }
    else {
        if (self.p_idArray.count == 1) {
            
            NSString *str = [NSString stringWithFormat:@"%@&p_id=%@",self.body,self.p_idArray[0]];
            NSURL *url            = [NSURL URLWithString:urlStr];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            request.HTTPMethod = @"POST";//设置请求方法
            request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
            [_webView loadRequest:request];
            NSLog(@"###############%@",str);
        }
        
        if (self.p_idArray.count != 1) {
            NSString *string = @"&p_id=";
            for (int i = 0 ; i < self.p_idArray.count ; i ++) {
                string = [string stringByAppendingFormat:@"%@",self.p_idArray[i]];
                if (i != self.p_idArray.count-1) {
                    string = [string stringByAppendingString:@","];
                }
            }
            NSString *str = [NSString stringWithFormat:@"%@%@",self.body,string];
            NSURL *url            = [NSURL URLWithString:urlStr];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            request.HTTPMethod = @"POST";//设置请求方法
            request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
            [_webView loadRequest:request];
            NSLog(@"###############%@",str);
        }
        
    }
    
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initForAutoLayout];
        _webView.delegate = self;
    }
    return _webView;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    return YES;
}

- (void)reloadWebView:(NSString *)urla{
    NSURL *url            = [NSURL URLWithString:urla];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

@end
