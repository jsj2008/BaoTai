//
//  LoginViewController.h
//  MallO2O
//
//  Created by mac on 15/6/10.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

typedef void(^LoginViewBlock)();

@interface LoginViewController : MallO2OBaseViewController

@property (weak, nonatomic) IBOutlet UIButton *logonBtn;

@property (nonatomic ,copy) NSString *identifier;
- (void)thirdID:(NSString *)thirdId reg:(NSString *)regType;

@property (copy ,nonatomic) LoginViewBlock loginBlock;

- (void)loginSuccess:(LoginViewBlock)block;
- (IBAction)logon:(UIButton *)sender;

@end
