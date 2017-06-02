//
//  SucceedViewController.m
//  MallO2O
//
//  Created by mac on 16/6/2.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "SucceedViewController.h"
#import "ShopTravelServeViewController.h"
@interface SucceedViewController ()

@end

@implementation SucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setNavBarTitle:NSLocalizedString(@"destineSucceedViewNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initUI {
    
    self.label.text = NSLocalizedString(@"destineSucceed", nil);
    [self.button setTitle:NSLocalizedString(@"inputMarkNotesCommitButtonTitle", nil) forState:UIControlStateNormal];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 5;
    self.button.backgroundColor = [UIColor colorWithRed:17/255.0 green:176/255.0 blue:244/255.0 alpha:1];
    self.label.textColor = UIColorFromRGB(0x898989);
    self.label.font = [UIFont systemFontOfSize:17];
}

// 确定按钮
- (IBAction)button:(UIButton *)sender {
    //遍历控制器 找到相应的控制器跳转
    for (MallO2OBaseViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[ShopTravelServeViewController class]]) {
            ShopTravelServeViewController *ccc = (ShopTravelServeViewController *)vc;
            [self.navigationController popToViewController:ccc animated:YES];
        }
    }
}
@end
