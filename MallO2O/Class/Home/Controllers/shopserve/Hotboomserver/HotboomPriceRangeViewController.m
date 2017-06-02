//
//  HotboomPriceRangeViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/16.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "HotboomPriceRangeViewController.h"

@interface HotboomPriceRangeViewController ()<UITextFieldDelegate>

@property (strong ,nonatomic) UIView *superView;

@property (strong ,nonatomic) UILabel *textLable;

@property (strong ,nonatomic) UITextField *lowPrice;

@property (strong ,nonatomic) UITextField *highPrice;

@property (strong ,nonatomic) UIButton *commitButton;

@end

@implementation HotboomPriceRangeViewController

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
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
}

- (void)viewWillDisappear:(BOOL)animated{
    
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
    
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"hotboomPriceRangeNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.superView];
    [self.superView addSubview:self.textLable];
    [self.superView addSubview:self.lowPrice];
    [self.superView addSubview:self.highPrice];
    [self.superView addSubview:self.commitButton];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.superView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.superView autoSetDimension:ALDimensionHeight toSize:152 * Balance_Heith];
    
    [self.textLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.textLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:33 * Balance_Heith];
    [self.textLable autoSetDimension:ALDimensionHeight toSize:24 * Balance_Heith];
    [self.textLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.lowPrice withOffset:0];
    
    [self.lowPrice autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:33 * Balance_Heith];
    [self.lowPrice autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:88 * Balance_Width];
    [self.lowPrice autoSetDimension:ALDimensionHeight toSize:24 * Balance_Heith];
    [self.lowPrice autoSetDimension:ALDimensionWidth toSize:88 * Balance_Width];
    
    UIView *line = [[UIView alloc] initForAutoLayout];
    [self.superView addSubview:line];
    [line autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:45 * Balance_Heith];
    [line autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.lowPrice withOffset:5 * Balance_Width];
    [line autoSetDimension:ALDimensionWidth toSize:15 * Balance_Width];
    [line autoSetDimension:ALDimensionHeight toSize:0.8 * Balance_Heith];
    line.backgroundColor = UIColorFromRGB(0x909090);
    
    [self.highPrice autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:33 * Balance_Heith];
    [self.highPrice autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.lowPrice withOffset:25 * Balance_Width];
    [self.highPrice autoSetDimension:ALDimensionWidth toSize:88 * Balance_Width];
    [self.highPrice autoSetDimension:ALDimensionHeight toSize:24 * Balance_Heith];
    
    [self.commitButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15*Balance_Width, 27 * Balance_Heith, 15 * Balance_Width) excludingEdge:ALEdgeTop];
    [self.commitButton autoSetDimension:ALDimensionHeight toSize:36 * Balance_Heith];
}

- (void)getPriceRange:(HotBoomPriceRangeBlock)block{
    self.priceRangeBlock = block;
}

- (void)clickCommitButton{
    if ([self.lowPrice.text floatValue] > [self.highPrice.text floatValue]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"hotboomServeViewControllerPriceRange", nil)];
        return;
    }
    if (self.priceRangeBlock) {
        self.priceRangeBlock([NSString stringWithFormat:@"%0.2f",[self.lowPrice.text floatValue]] , [NSString stringWithFormat:@"%0.2f",[self.highPrice.text floatValue]]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 控件的初始化
- (UIView *)superView{
    if (!_superView) {
        _superView = [[UIView alloc] initForAutoLayout];
        _superView.backgroundColor = UIColorFromRGB(0xffffff);
    }
    return _superView;
}

- (UILabel *)textLable{
    if (!_textLable) {
        _textLable = [[UILabel alloc] initForAutoLayout];
        _textLable.textColor = UIColorFromRGB(0x565656);
        _textLable.text = NSLocalizedString(@"hotboomPriceRangeNavigationTitle", nil);
        _textLable.font = [UIFont systemFontOfSize:15];
        _textLable.textAlignment = NSTextAlignmentCenter;
    }
    return _textLable;
}

- (UITextField *)lowPrice{
    if (!_lowPrice) {
        _lowPrice = [[UITextField alloc] initForAutoLayout];
        _lowPrice.layer.borderColor = UIColorFromRGB(0x1a9ded).CGColor;
        _lowPrice.layer.borderWidth = 1;
        _lowPrice.layer.cornerRadius = 6;
        _lowPrice.layer.masksToBounds = YES;
        _lowPrice.font = [UIFont systemFontOfSize:15];
        _lowPrice.textAlignment = NSTextAlignmentCenter;
        _lowPrice.delegate = self;
    }
    return _lowPrice;
}

- (UITextField *)highPrice{
    if (!_highPrice) {
        _highPrice = [[UITextField alloc] initForAutoLayout];
        _highPrice.layer.borderColor = UIColorFromRGB(0x1a9ded).CGColor;
        _highPrice.layer.borderWidth = 1;
        _highPrice.layer.cornerRadius = 6;
        _highPrice.layer.masksToBounds = YES;
        _highPrice.font = [UIFont systemFontOfSize:15];
        _highPrice.textAlignment = NSTextAlignmentCenter;
        _highPrice.delegate = self;
    }
    return _highPrice;
}

- (UIButton *)commitButton{
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] initForAutoLayout];
        _commitButton.backgroundColor = UIColorFromRGB(0x1a9ded);
        _commitButton.layer.cornerRadius = 5;
        _commitButton.layer.masksToBounds = YES;
        [_commitButton setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateNormal];
        _commitButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_commitButton addTarget:self action:@selector(clickCommitButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

@end
