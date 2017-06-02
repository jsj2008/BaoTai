//
//  AppDelegate.m
//  MallO2O
//
//  Created by songweiping on 15/5/26.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"
#import "TabBarViewController.h"

#import "PayPalMobile.h"

#import "MallO2OBaseViewController.h"

#import "GoodsWebViewController.h"
#import "OrderDetailViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSnsService.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "WXApi.h"
#import "payRequsestHandler.h"
#import "WechatOrderInformation.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PushOrderSuccessViewController.h"
#import "PushOrderViewController.h"
#import "UMSocial.h"
#import "Pingpp.h"

#import "UPPaymentControl.h"

#import "SwpTools.h"
#import "SwpNetworkModel.h"

#import "PersonInfoModel.h"

#import "MobClick.h"

@interface AppDelegate ()<UIAlertViewDelegate,WXApiDelegate>

@property (strong ,nonatomic) NSString *messageUrl;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self settingSVProgressHUD];
    // 项目版本号--一次调用
    self.applicationVersion = [UZCommonMethod checkAPPVersion];

    // 判断系统版本--一次调用
    self.systemVersion      = [UZCommonMethod checkSystemVersion];

    // 设置网路引擎
//    self.baseEngine         = [[BaseEngine alloc] initWithHostName:baseUrl];
    // 登陆状态
    self.login              = NO;
    
//    SetUserDefault(@"NO", IsLogin);
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"UGfKy2BYtvqFP3EA0s4uh3PB"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
    [self getInfoFromNetWork];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = [[UIViewController alloc] init];
    self.window.backgroundColor     = [UIColor whiteColor];
    self.window.rootViewController  = [[TabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    
//    if (GetUserDefault(ThirdId) != nil && ![GetUserDefault(ThirdId) isEqualToString:@""]) {
//        [self autoThirdLogin];
//    }else{
        [self autoLogin];
//    }
    
    
    /**
     分享
     */
//    [UMSocialData setAppKey:@"55ebb05167e58e3c3e000e7a"];
    [UMSocialData setAppKey:@"56458b5ce0f55abed8002120"];
    [MobClick startWithAppkey:@"56458b5ce0f55abed8002120" reportPolicy:BATCH   channelId:@""];
    [self setShare];
//    [WXApi registerApp:@"wx123c12f58570d7d4" withDescription:@"demo 2.0"];
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]
//                                                   bounds]];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    // Required
    
    /*----设置icon提示数为0----*/
    [application setApplicationIconBadgeNumber:0];
    
    // 推送
#if  __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //categories
            [APService
             registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                 UIUserNotificationTypeSound |
                                                 UIUserNotificationTypeAlert)
             categories:nil];
        } else {
            //categories nil
            [APService
             registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                 UIUserNotificationTypeSound |
                                                 UIUserNotificationTypeAlert)
#else
             //categories nil
             categories:nil];
            [APService
             registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                 UIRemoteNotificationTypeSound |
                                                 UIRemoteNotificationTypeAlert)
#endif
             // Required
             categories:nil];
        }
    [NSThread sleepForTimeInterval:2.0];
    [APService setupWithOption:launchOptions];
    //向微信注册
    [UMSocialData openLog:YES];
    [WXApi registerApp:APP_ID withDescription:@"demo 2.0"];
    return YES;
}
#pragma mark - 设置paypal
- (void)setPapPal{
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"YOUR_CLIENT_ID_FOR_PRODUCTION",
                                                           PayPalEnvironmentSandbox : @"YOUR_CLIENT_ID_FOR_SANDBOX"}];
}

#pragma mark 设置分享
/**
     设置分享
 */
- (void)setShare{
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:APP_ID appSecret:@"7659d48c83213cc8d9ba37a631e471f2" url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:@"1104577798" appKey:@"v5YY6Dj6iyyn3D0N" url:@"http://www.umeng.com/social"];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
secret:@"04b48b094faeb16683c32669824ebdad"
RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

#pragma mark 分享回调
/**
    友盟分享回掉
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.host isEqualToString:@"pingpp"]) {
        NSLog(@"ping++回调");
    }
    if ([url.host isEqualToString:@"safepay"] || [url.host isEqualToString:@"pay"]) {
        BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
        return canHandleURL;
    }
    return  [UMSocialSnsService handleOpenURL:url];
}

// 当用户通过其它应用启动本应用时，会回调这个方法，url参数是其它应用调用openURL:方法时传过来的
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([url.host isEqualToString:@"pingpp"]) {
        NSLog(@"ping++回调");
    }
    if ([url.host isEqualToString:@"safepay"] || [url.host isEqualToString:@"pay"]) {
        BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
        return canHandleURL;
    }
    
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    
    NSLog(@"%@", url.host);
    if ([url.host isEqualToString:@"uppayresult"]) {
        [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
            NSLog(@"code = %@ and data = %@",code,data);
            if ([code isEqualToString:@"fail"]) {
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
            }
            if ([code isEqualToString:@"cancle"]) {
                [SVProgressHUD showErrorWithStatus:@"取消支付"];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aaa" object:code];
        }];
    }
    if ([url.host isEqualToString:@"pingpp"]) {
        NSLog(@"ping++回调");
    }
    if ([url.host isEqualToString:@"safepay"] || [url.host isEqualToString:@"pay"] || [url.host isEqualToString:@"pingpp"]) {
        BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
        return canHandleURL;
    } else {
        return  [UMSocialSnsService handleOpenURL:url];
    }
    
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    [APService registerDeviceToken:deviceToken];
}
    
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
    NSLog(@"%@",userInfo);
    NSString *string = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:string
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [APService handleRemoteNotification:userInfo];
}

#pragma mark------收到通知回调
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void
                        (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"%@",userInfo);
    _messageUrl = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"message_url"]];
    
    if (application.applicationState == UIApplicationStateActive) {
        [self showPushMessage:userInfo];
        
    }else{
        [self didPushMessageJumpController:_messageUrl];
    }
    
    [application setApplicationIconBadgeNumber:0];
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark 收到推送通知
- (void)showPushMessage:(NSDictionary *)userInfo{
    NSString *string = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:string
                                                       delegate:self
                                              cancelButtonTitle:@"去看看"
                                              otherButtonTitles:nil];
    alertView.tag = 3;
    [alertView show];
}

/**
    alertview的代理方法
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self didPushMessageJumpController:_messageUrl];
    }
}

#pragma mark---------设备号获取以及回调函数
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

#pragma mark----设置别名
-(void)setAlian :(NSString*)alian
{
    [APService setTags:nil
                 alias:alian
      callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                target:self];
}

- (void)didPushMessageJumpController: (NSString *)url{
    TabBarViewController *tabBarVC = (TabBarViewController *)self.window.rootViewController;
    NSInteger index = tabBarVC.selectedIndex;
    MallO2OBaseViewController *baseVC = [tabBarVC.viewControllers objectAtIndex:index];
    UIViewController    *currentViewCtrl     = ((UINavigationController*)baseVC).topViewController;
    
    int isExist = 0;
    // 取出 所有控制器
    NSArray *subViews = currentViewCtrl.navigationController.viewControllers;
    
    // 循环遍历 找出跳转的控制器是否存在
    OrderDetailViewController *shopOreder      = [[OrderDetailViewController alloc] init];
    for (MallO2OBaseViewController *obj in subViews) {
        if ([obj isKindOfClass:[OrderDetailViewController class]]) {
            isExist    = 1;
            shopOreder = (OrderDetailViewController *)obj;
            break;
        }
    }
    
    // 控制器是否存在
    if (isExist == 0) {
        // 不存在 跳转
        shopOreder.webUrl = url;
        [shopOreder.rdv_tabBarController setTabBarHidden:YES animated:YES];
        shopOreder.identifier = @"1";
        [currentViewCtrl.navigationController pushViewController:shopOreder animated:YES];
    } else{
        // 存在 刷新
        [shopOreder reloadWebView:url];
    }

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 获取主接口数据
/**
 *  getInfoFromNetWork 写入plist 文件
 *  获取主接口数据
 */
-(void)getInfoFromNetWork {
    
    
    SwpNetworkModel *swpNetwork = [SwpNetworkModel shareInstance];
    
    //    [JSONOfNetWork createPlist:nil];
    NSString *url         = [NSString stringWithFormat:@"http://%@/%@", baseUrl, base_set];
    NSString *sys_type    = [[UIDevice currentDevice] systemName];
    NSString *sys_version = [[UIDevice currentDevice] systemVersion];
    NSString *device_type = @"iPhone";
    NSString *brand       = @"苹果";
    NSString *model       = [[UIDevice currentDevice] model]  ;
    NSString *lat         = @"126.650516";
    NSString *lng         = @"45.759086";
    NSString *u_id        = @"0";
    
    NSDictionary *paramDic = @{
                               @"sys_type":    sys_type,
                               @"sys_version": sys_version,
                               @"device_type": device_type,
                               @"brand":       brand,
                               @"model":       model,
                               @"app_key":     url,
                               @"lat":         lat,
                               @"lng":         lng,
                               @"u_id":        u_id
                               };
    
    
    [SwpRequest swpPOST:url parameters:paramDic isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            if ([SwpTools swpToolDataWriteToPlist:resultObject plistName:nil]) {
                NSDictionary *dictData = [SwpTools swpToolGetDictionaryFromPlist:nil];
                NSLog(@"%@", dictData);
//                if ([JSONOfNetWork createPlist:resultObject]) {
//                    NSLog(@"写入完成");
//                    self.baseDict=[JSONOfNetWork getDictionaryFromPlist];
//                    NSLog(@"%@", self.baseDict);
//                }
            }
        } else {
            [SVProgressHUD showErrorWithStatus:resultObject[swpNetwork.swpNetworkMessage]];
        }

    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
    
//    [Base64Tool postSomethingToServe:base_set andParams:paramDic isBase64:[IS_USE_BASE64 boolValue] CompletionBlock:^(id param) {
//        NSLog(@"message:%@",[param objectForKey:@"message"]);
//        if ([param[@"code"] integerValue] == 200) {
//            if ([JSONOfNetWork createPlist:param]) {
//                NSLog(@"写入完成");
//                self.baseDict=[JSONOfNetWork getDictionaryFromPlist];
//                NSLog(@"%@", self.baseDict);
//            }
//        } else {
//            
//        }
//        
//    } andErrorBlock:^(NSError *error) {
//        NSLog(@"time out");
//    }];
    
}

#pragma mark 自动登录
/**
 *  自动登录
 */
- (void)autoLogin{
    
    SwpNetworkModel *swpNetwork = [SwpNetworkModel shareInstance];
//    NSLog(@"%@",GetUserDefault(passw));
    if ([GetUserDefault(IsLogin) boolValue]) {
        NSString *url = @"http://baotai.youzhiapp.com/action/ac_user/yz_login";
        if (GetUserDefault(UserName) == nil || [GetUserDefault(UserName) isEqualToString:@""]) {
            SetUserDefault(@"NO", IsLogin);
            [[NSUserDefaults standardUserDefaults] synchronize];
            return;
        }
        NSDictionary *dic = @{
                              @"app_key" : url,
                              @"user_name" : GetUserDefault(UserName),
                              @"user_pass" : GetUserDefault(PassWord),
                              @"reg_type" : @"0",
                              @"th_id" : @"0"
                              };
        
        
        [SwpRequest swpPOST:url parameters:dic isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
            
            if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
                [PersonInfoModel savePersonInfo:resultObject[@"obj"]];
                SetUserDefault(@"YES", IsLogin);
                [self setAlian:[@"user_" stringByAppendingFormat:@"%@", resultObject[@"obj"][@"u_id"] ]];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }else{
                SetUserDefault(@"NO", IsLogin);
                [PersonInfoModel clearPersonInfo];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            [PersonInfoModel clearPersonInfo];
        }];
    }
}
/**
 *  三方自动登录
 */
- (void)autoThirdLogin{
    if ([GetUserDefault(IsLogin) boolValue]) {
        SwpNetworkModel *swpNetwork = [SwpNetworkModel shareInstance];
        NSString *url = [SwpTools swpToolGetInterfaceURL:@"yz_login"];//@"action/ac_user/yz_login";
        NSDictionary *dic = @{
                              @"app_key" : url,
                              @"reg_type" : GetUserDefault(LoginType),
                              @"th_id" : GetUserDefault(ThirdId),
                              @"user_pass" : @"0"
                              };
        
        
        [SwpRequest swpPOST:url parameters:dic isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
            
            if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
                [PersonInfoModel savePersonInfo:resultObject[@"obj"]];
                SetUserDefault(@"YES", IsLogin);
                [self setAlian:[@"user_" stringByAppendingFormat:@"%@", resultObject[@"obj"][@"u_id"] ]];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                SetUserDefault(@"NO", IsLogin);
                [PersonInfoModel clearPersonInfo];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            [PersonInfoModel clearPersonInfo];
        }];
    }
}


- (void)settingSVProgressHUD {
    // 背景颜色
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
//    [SVProgressHUD setFadeOutAnimationDuration:1];
}


@end
