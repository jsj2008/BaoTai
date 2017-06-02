//
//  LoginViewController.m
//  MallO2O
//
//  Created by mac on 15/6/10.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "ForgetPassViewController.h"
#import "ShoppingCartViewController.h"
#import "APService.h"
#import "UMSocial.h"


#import "SwpTools.h"

#import "ThirdRegistViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *accountTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton    *loginButton;

@property (nonatomic, weak) IBOutlet UIButton    *forgotPasswordButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    [self addUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = UIColorFromRGB(0xf3f3f3);
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if ([_identifier isEqualToString:@"1"]) {
        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    }else{
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    }
}

- (void)popViewController{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 初始化数据
/**
    初始化数据
 */
- (void)initData{
    self.accountTextField.text = GetUserDefault(UserName);
    if ([GetUserDefault(IS_REMEBER) boolValue]) {
//        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sel_remember"]];
//        _passwordText.text = GetUserDefault(PassWord);
//        [_remImgButton setBackgroundImage:imgView.image forState:UIControlStateNormal];
    }else{
//        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_remember"]];
//        [_remImgButton setBackgroundImage:imgView.image forState
//                                         :UIControlStateNormal];
    }
}

/**
   添加控件
 */
- (void)addUI{
    
    
    self.accountTextField.placeholder = NSLocalizedString(@"loginAccountPlaceholder", nil);
    
    self.passwordTextField.placeholder = NSLocalizedString(@"loginPasswordPlaceholder", nil);
    
    
    
//    self.forgetPass.text = NSLocalizedString(@"loginForgetPassword", nil);
    
    [self.loginButton setTitle:NSLocalizedString(@"loginButtonTitle", nil) forState:UIControlStateNormal];
    [self.loginButton setTitle:NSLocalizedString(@"loginButtonTitle", nil) forState:UIControlStateHighlighted];
    
    [self.forgotPasswordButton setTitle:NSLocalizedString(@"loginForgetPassword", nil) forState:UIControlStateNormal];
     [self.forgotPasswordButton setTitle:NSLocalizedString(@"loginForgetPassword", nil) forState:UIControlStateHighlighted];

    
    [self initUI];
    [self setNavi];
    [self setUI];
    
    
}

/**
    初始化控件
 */
- (void)initUI{
    /**
         咳咳
//     */
//    _qqLogin.layer.cornerRadius = _qqLogin.frame.size.height/2;
//    _qqLogin.layer.masksToBounds = YES;
//    [_qqLogin setBackgroundImage:[UIImage imageNamed:@"qq_login"] forState:UIControlStateNormal];
//    
//    _wxLogin.layer.cornerRadius = _wxLogin.frame.size.height/2;
//    _wxLogin.layer.masksToBounds = YES;
//    [_wxLogin setBackgroundImage:[UIImage imageNamed:@"wx_login"] forState:UIControlStateNormal];
    
//    _sinaLogin.layer.cornerRadius = _sinaLogin.frame.size.height/2;
//    _sinaLogin.layer.masksToBounds = YES;
//    [_sinaLogin setBackgroundImage:[UIImage imageNamed:@"sina_login"] forState:UIControlStateNormal];
    
    self.accountTextField.delegate = self;
}

/**
    设置控件
 */
- (void)setUI{
    /**
        无聊的设置，更改UI时可能需要修改
     */
//    _loginButton.layer.masksToBounds = YES;
//    _loginButton.layer.cornerRadius = 4;
    
//    UIView *xian = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
//    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
//    [_textFieldView addSubview:xian];
//    xian = [[UIView alloc] initWithFrame:CGRectMake(0, _textFieldView.frame.size.height / 2, SCREEN_WIDTH , 1)];
//    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
//    [_textFieldView addSubview:xian];
//    xian = [[UIView alloc] initWithFrame:CGRectMake(0, _textFieldView.frame.size.height, SCREEN_WIDTH, 1)];
//    xian.backgroundColor = UIColorFromRGB(0xe5e5e5);
//    [_textFieldView addSubview:xian];
//    
//    _passwordText.secureTextEntry = YES;
    
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPassGes)];
//    _forgetPass.userInteractionEnabled = YES;
//    [_forgetPass addGestureRecognizer:gesture];
}

/**
    忘记密码的点击事件
 */
- (void)jumpForgetPassController {
    ForgetPassViewController *viewController = [[ForgetPassViewController alloc] init];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
    设置导航栏
 */
- (void)setNavi{
    [self setNavBarTitle:NSLocalizedString(@"loginNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
//    [self setBackButton];
//    [self setNaviRightButton];
}

/**
    导航栏右侧注册按钮
 */
- (void)setNaviRightButton{
    UIButton* rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame=CGRectMake(0, 0, 50* Balance_Width, 30);
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    rightButton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, -40);
    [rightButton setTitle:NSLocalizedString(@"loginRegister", nil) forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(jumpRegistController) forControlEvents:UIControlEventTouchUpInside];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//  rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
}

/**
    实现注册的点击事件
 */
- (void)jumpRegistController {
    [self.view endEditing:YES];
    RegistViewController *regist = [RegistViewController new];
    regist.naviTitle             = NSLocalizedString(@"loginRegister", nil);
    [self.navigationController pushViewController:regist animated:YES];
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


- (IBAction)didButton:(UIButton *)button {
    
    
    if (button.tag == 0) {
        if (![self checkLoginInfo]) return;
        [self loginWithUrl];
    }
    
    if (button.tag == 1) [self jumpForgetPassController];
    
}
#pragma mark 登录上传数据
- (void)loginWithUrl{
//    if (![UZCommonMethod inputString:_usernameText.text]) {
//        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccount", nil)];
//        return;
//    }
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"yz_login"];
   
//    SetUserDefault(_usernameText.text, UserName);
//    if ([GetUserDefault(IS_REMEBER) boolValue]) {
//        SetUserDefault(_passwordText.text, PassWord);
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }else{
//        SetUserDefault(@"", _passwordText.text);
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    NSDictionary *dic = @{
                          @"app_key"   : url,
                          @"user_name" : self.accountTextField.text,
                          @"user_pass" : self.passwordTextField.text,
                          @"reg_type"  : @"0",
                          @"th_id"     : @"0"
                          };
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        /*
         登录时本地存储一些数据  根据key能看出存储什么数据
         */
        SetUserDefault(@"YES", IsLogin);
        SetUserDefault(self.accountTextField.text, UserName);
        SetUserDefault(self.passwordTextField.text, PassWord);
//        NSLog(@"%@",SetUserDefault(self.passwordTextField.text, PassWord));
        NSLog(@"%@",GetUserDefault(PassWord));
        SetUserDefault(@"", ThirdId);
        [[NSUserDefaults standardUserDefaults] synchronize];
        [PersonInfoModel savePersonInfo:resultObject[@"obj"]];
        [self setAlian:[@"user_" stringByAppendingFormat:@"%@", resultObject[@"obj"][@"u_id"]]];
        /**
         获取当前栈里的viewcontroller并变成一数组
         */
        NSArray *array = self.navigationController.viewControllers;
        /*
         定义一个购物车的控制器
         */
        ShoppingCartViewController *viewController = array[0];
        /*
         判断返回的上个界面是否是购物车的控制器
         如果是，pop时隐藏navigationbar
         如果不是，pop时什么都不管
         */
        [self.view endEditing:YES];
        if ([viewController isKindOfClass:[ShoppingCartViewController class]]) {
            [viewController.navigationController setNavigationBarHidden:YES];
            [self.navigationController popToViewController:viewController animated:YES];
        }else{
            if (self.loginBlock) {
                self.loginBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"loginSuccess", nil)];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
    
}

- (void)loginSuccess:(LoginViewBlock)block{
    self.loginBlock = block;
}

- (IBAction)logon:(UIButton *)sender {
    
    [self.view endEditing:YES];
    RegistViewController *regist = [RegistViewController new];
    regist.naviTitle             = NSLocalizedString(@"loginRegister", nil);
    [self.navigationController pushViewController:regist animated:YES];
    
}

- (void)thirdID:(NSString *)thirdId reg:(NSString *)regType{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"yz_login"];//@"action/ac_user/yz_login";
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"reg_type" : regType,
                          @"th_id" : thirdId,
                          @"user_pass" : @"0"
                          };
    
    
    [self swpPublicTooGetDataToServer:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        /*
         登录时本地存储一些数据  根据key能看出存储什么数据
         */
        SetUserDefault(@"YES", IsLogin);
//        SetUserDefault(resultObject[@"obj"][@"u_id"], U_ID);
//        SetUserDefault(resultObject[@"obj"], Person_Info);
        [PersonInfoModel savePersonInfo:resultObject[@"obj"]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self setAlian:[@"user_" stringByAppendingFormat:@"%@", resultObject[@"obj"][@"u_id"] ]];
        /**
         获取当前栈里的viewcontroller并变成一数组
         */
        NSArray *array = self.navigationController.viewControllers;
        /*
         定义一个购物车的控制器
         */
        ShoppingCartViewController *viewController = array[array.count - 1];
        /*
         判断返回的上个界面是否是购物车的控制器
         如果是，pop时隐藏navigationbar
         如果不是，pop时什么都不管
         */
        [self.view endEditing:YES];
        if ([viewController isKindOfClass:[ShoppingCartViewController class]]) {
            [viewController.navigationController setNavigationBarHidden:YES];
            [self.navigationController popToViewController:viewController animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"loginSuccess", nil)];

    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        ThirdRegistViewController *viewController = [[ThirdRegistViewController alloc] init];
        viewController.regType = regType;
        viewController.thirdID = thirdId;
        viewController.naviTitle = NSLocalizedString(@"thirdRegistNavigationTitle", nil);
        [self.view endEditing:YES];
        [self.navigationController pushViewController:viewController animated:YES];
        [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];

    }];
}

- (BOOL)checkLoginInfo {
    
    
    if ([SwpTools swpToolTrimString:self.accountTextField.text].length == 0) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccountNULLMessage", nil)];
        return NO;
    }
    
    if ([SwpTools swpToolTrimString:self.passwordTextField.text].length == 0) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckPasswordNULLMessage", nil)];
        return NO;
    }
    
    NSString    *mailboxesAre = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate    = [NSPredicate predicateWithFormat:@"self matches %@", mailboxesAre];
    if (![predicate evaluateWithObject:self.accountTextField.text]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccount", nil)];
        return NO;
    }
    
    return YES;
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return textField.textInputMode != nil;
}

@end
