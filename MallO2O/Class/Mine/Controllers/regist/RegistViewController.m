//
//  RegistViewController.m
//  MallO2O
//
//  Created by mac on 15/6/10.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "RegistViewController.h"
#import "LoginViewController.h"

#import "SwpTools.h"

@interface RegistViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *accountTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton    *registButton;

@end

@implementation RegistViewController{
    NSString *codeString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    codeString = [[NSString alloc] init];
    [self initUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = UIColorFromRGB(0xf3f3f3);
}

/**
 初始化UI
 */
- (void)initUI{
    [self setUI];
    [self setNavi];
//    [self addXian];
}

/**
 设置导航栏
 */
- (void)setNavi{
    [self setNavBarTitle:self.naviTitle withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 设置控件
 */
- (void)setUI{

    self.accountTextField.delegate     = self;
    self.accountTextField.placeholder  = NSLocalizedString(@"registAccountPlaceholder", nil);
    self.passwordTextField.placeholder = NSLocalizedString(@"registPasswordAccountPlaceholder", nil);
    
    [self.registButton setTitle:NSLocalizedString(@"registButtonTitle", nil) forState:UIControlStateNormal];
    [self.registButton setTitle:NSLocalizedString(@"registButtonTitle", nil) forState:UIControlStateHighlighted];
}


- (void)popViewController{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 点击注册按钮
- (IBAction)didRegistButton:(UIButton *)button {

    if (![self checkRegistInfo]) return;
    [self registCommitData];
    
}


- (void)registCommitData {
    
    NSString     *url        = [SwpTools swpToolGetInterfaceURL:@"yz_reg"];
    NSDictionary *dictionary = @{
                                 @"app_key"     : url,
                                 @"user_name"   : self.accountTextField.text,
                                 @"user_pass"   : self.passwordTextField.text,
                                 @"reg_type"    : @"0",
                                 @"th_id"       : @"0",
                                 };
    
    [self swpPublicTooGetDataToServer:url parameters:dictionary isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        if ([resultObject[@"code"] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
            [self.view endEditing:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

- (BOOL)checkRegistInfo {
    
    
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
    
    if ([SwpTools swpToolTrimString:self.passwordTextField.text].length == 0) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckPasswordNULLMessage", nil)];
        return NO;
    }
    
    return YES;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
//    if ([textField.placeholder isEqualToString:@"请输入正确电话"]) {
//        NSCharacterSet*cs;
//        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
//        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        BOOL basicTest = [string isEqualToString:filtered];
//        if(!basicTest) {
//            return NO;
//        }
//    }
    
    return YES;
}
@end
