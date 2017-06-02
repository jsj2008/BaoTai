//
//  BigTradeOrderSeccessViewController.m
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeOrderSeccessViewController.h"


/*! ---------------------- Tool       ---------------------- !*/
#import "UIColor+SwpColor.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
/*! ---------------------- Tool       ---------------------- !*/

/*! ---------------------- Controller ---------------------- !*/
/*! ---------------------- Controller ---------------------- !*/

/*! ---------------------- View       ---------------------- !*/
/*! ---------------------- View       ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/
/*! ---------------------- Model      ---------------------- !*/

@interface BigTradeOrderSeccessViewController ()
#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/

@property (nonatomic, weak) IBOutlet UIButton *returnHomeButton;
/*! ---------------------- UI   Property  ---------------------- !*/

#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
/*! ---------------------- Data Property  ---------------------- !*/

@end

@implementation BigTradeOrderSeccessViewController

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
    [self settingUIProperty];
    
}


/*!
 *  @author swp_song
 *
 *  @brief  设置导航栏
 */
- (void) settingNavigationBar {
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
    [self setNavBarTitle:NSLocalizedString(@"bigTradeOrderSeccessNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/*!
 *  @author swp_song
 *
 *  @brief  setupUI ( 添加控件 | 设置控件自动布局 )
 */
- (void) setUpUI {
    
}

/*!
 *  @author swp_song
 *
 *  @brief  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

/*!
 *  @author swp_song
 *
 *  @brief settingUIProperty ( 设置 UI 控件 属性 )
 */
- (void) settingUIProperty {
    self.returnHomeButton.layer.borderColor = [UIColor swpColorFromHEX:0x11b0f4].CGColor;
    [self.returnHomeButton setTitle:NSLocalizedString(@"bigTradeOrderSeccessReturnHomeButtonTitle", nil) forState:UIControlStateNormal];
}

- (IBAction)ckeckButton:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
