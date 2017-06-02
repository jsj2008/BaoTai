//
//  ForgetPassViewController.m
//  MallO2O
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "ForgetPassViewController.h"
#import "ChangeForgetPassViewController.h"


@interface ForgetPassViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *accountTextField;
@property (nonatomic, weak) IBOutlet UIButton    *commitButton;

@end

@implementation ForgetPassViewController
#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  将要加载出视图 调用
 *
 *  @param animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = UIColorFromRGB(0xf3f3f3);
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    
    
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {

    self.accountTextField.placeholder  = NSLocalizedString(@"forgetPasswordAccountPlaceholder", nil);
    
    [self.commitButton setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateNormal];
    [self.commitButton setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateHighlighted];
    
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"forgetPasswordNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    self.accountTextField.delegate = self;
}



/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

- (IBAction)didButton:(UIButton *)button {
    [self.view endEditing:YES];
    
    if (![self checkForgetPassInfo]) return;
    
    [self forgetPasswordCommitData];
    
    
}



- (void)forgetPasswordCommitData {
    
    NSString     *url        = [SwpTools swpToolGetInterfaceURL:@"yz_find_pass"];
    NSDictionary *dictionary = @{
                                 @"app_key"     : url,
                                 @"user_name"   : self.accountTextField.text,
                                 };
    
    [self swpPublicTooGetDataToServer:url parameters:dictionary isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        [SVProgressHUD showSuccessWithStatus:resultObject[self.swpNetwork.swpNetworkMessage]];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

- (BOOL)checkForgetPassInfo {
    
    
    if ([SwpTools swpToolTrimString:self.accountTextField.text].length == 0) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccountNULLMessage", nil)];
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

@end
