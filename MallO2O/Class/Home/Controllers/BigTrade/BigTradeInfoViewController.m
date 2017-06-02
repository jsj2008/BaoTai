//
//  BigTradeInfoViewController.m
//  MallO2O
//
//  Created by songweiping on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeInfoViewController.h"

/*! ---------------------- Tool       ---------------------- !*/
#import "SwpWeakifyHeader.h"
#import <Masonry/Masonry.h>
#import "SwpTools.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridgeBase.h>
/*! ---------------------- Tool       ---------------------- !*/

/*! ---------------------- Controller ---------------------- !*/
#import "BigTradeOrderViewController.h"
#import "LoginViewController.h"
#import "ShopCarIndependenceViewController.h"
/*! ---------------------- Controller ---------------------- !*/

/*! ---------------------- View       ---------------------- !*/
/*! ---------------------- View       ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/

@interface BigTradeInfoViewController ()<UIWebViewDelegate>


#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
@property (nonatomic, strong) UIWebView               *bigTradeInfoView;
@property (nonatomic, strong) WebViewJavascriptBridge *bigTradeInfoBridge;


/*! ---------------------- UI   Property  ---------------------- !*/

#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
/*! ---------------------- Data Property  ---------------------- !*/

@end

@implementation BigTradeInfoViewController

#pragma mark - Lifecycle Methods
/*!
 *  @author swp_song
 *
 *  @brief  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingUI];
    
    [self settingData];
    [self settingWebViewJavascriptBridge];
}

/*!
 *  @author swp_song
 *
 *  @brief  将要加载出视图 调用
 *
 *  @param  animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

/*!
 *  @author swp_song
 *
 *  @brief  视图 显示 窗口时 调用
 *
 *  @param  animated
 */
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/*!
 *  @author swp_song
 *
 *  @brief 视图  即将消失、被覆盖或是隐藏时调用
 *
 *  @param animated
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Do any additional setup after loading the view.
}

/*!
 *  @author swp_song
 *
 *  @brief  视图已经消失、被覆盖或是隐藏时调用
 *
 *  @param  animated
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

/*!
 *  @author swp_song
 *
 *  @brief  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*!
 *  @author swp_song
 *
 *  @brief  当前 控制器 被销毁时 调用
 */
- (void) dealloc {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - Setting Data Method
/*!
 *  @author swp_song
 *
 *  @brief  设置 初始化 数据
 */
- (void) settingData {
    
}

#pragma mark - Setting UI Methods
/*!
 *  @author swp_song
 *
 *  @brief  设置 UI 控件
 */
- (void) settingUI {
    
    [self settingNavigationBar];
    [self setUpUI];
    [self settingUIAutoLayout];
    
}


/*!
 *  @author swp_song
 *
 *  @brief  设置导航栏
 */
- (void) settingNavigationBar {
    [self setNavBarTitle:NSLocalizedString(@"bigTradeInfoNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/*!
 *  @author swp_song
 *
 *  @brief  setupUI ( 添加控件 | 设置控件自动布局 )
 */
- (void) setUpUI {
    
    [self.view addSubview:self.bigTradeInfoView];
    self.bigTradeInfoView.delegate = self;
}

- (void) settingWebViewJavascriptBridge {
    
    @swpWeakify(self);
//    [WebViewJavascriptBridge enableLogging];
//    [_bigTradeInfoBridge setWebViewDelegate:self];
//    _bigTradeInfoBridge = [WebViewJavascriptBridge bridgeForWebView:self.bigTradeInfoView];
    [self setwebBridge:self.bigTradeInfoView andDelegate:self getBridgeID:@"bigtrade_pay" complete:^(id data, WVJBResponseCallback callBack) {
        @swpStrongify(self);
        
        NSLog(@"%@", data);
        if (![self checkLogin]) return;
        [self setBigTradeInfoURL:self.bigTradeInfoURL];
        [self userAddressGetData:[NSDictionary dictionaryWithDictionary:data]];
        
        callBack(@"Response from testObjcCallback");
    }];
    
}

/*!
 *  @author swp_song
 *
 *  @brief  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
    @swpWeakify(self);
    [self.bigTradeInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @swpStrongify(self);
        make.edges.equalTo(self.view);
    }];
}

- (void)setBigTradeInfoURL:(NSString *)bigTradeInfoURL {
    _bigTradeInfoURL = bigTradeInfoURL;
    [SwpTools swpToolWebViewLoadServersURL:self.bigTradeInfoView serversURLString:[NSString stringWithFormat:@"%@&u_id=%@", _bigTradeInfoURL, [PersonInfoModel shareInstance].uID]];
}

- (BOOL)checkLogin {
    
    NSLog(@"%@", GetUserDefault(IsLogin));
    if ([GetUserDefault(IsLogin) boolValue] == NO) {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        [self.navigationController pushViewController:viewController animated:YES];
        return NO;
    }
    
    return YES;
}

- (void)userAddressGetData:(NSDictionary *)data {
    
    NSString     *url        = [SwpTools swpToolGetInterfaceURL:@"my_address_is"];
    NSDictionary *dictionary = @{
                                 @"app_key" : url,
                                 @"u_id"    : [PersonInfoModel shareInstance].uID,
                                 };
    
    [self swpPublicTooGetDataToServer:url parameters:dictionary isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        
        SetUserDefault(resultObject[self.swpNetwork.swpNetworkObject], Address);
        BigTradeOrderViewController *bigTradeOrder = [BigTradeOrderViewController new];
        bigTradeOrder.shopInfo                     = [NSDictionary dictionaryWithDictionary:data];
        [self.navigationController pushViewController:bigTradeOrder animated:YES];
        
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        
    }];
    
    NSLog(@"%@", dictionary);
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = [request URL];
    NSLog(@"%@",[url scheme]);
    if ([[url scheme] isEqualToString:@"myapp"]) {
        //        [self.rdv_tabBarController setSelectedIndex:2];
        if ([self checkLogin]) {
            ShopCarIndependenceViewController *viewController = [[ShopCarIndependenceViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
    if ([[url scheme] isEqualToString:@"login"]) {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        @swpWeakify(self);
        [viewController loginSuccess:^{
            @swpStrongify(self);
            [self setBigTradeInfoURL:self.bigTradeInfoURL];
        }];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    return YES;
}


- (UIWebView *)bigTradeInfoView {
    return !_bigTradeInfoView ? _bigTradeInfoView = ({
        UIWebView *webView = [[UIWebView alloc] init];
        webView;
    }) : _bigTradeInfoView;
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
