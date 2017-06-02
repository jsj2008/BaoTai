//
//  BackJourneyViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/14.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BackJourneyViewController.h"

#import "ChoosePassengerViewController.h"

#import "FlightTableViewCell.h"

@interface BackJourneyViewController ()<UITableViewDataSource ,UITableViewDelegate>

@property (strong ,nonatomic) UITableView *flightTableView;
/**
 *  去程的小图标
 */
@property (strong ,nonatomic) UILabel *goOnImageView;
/**
 *  去程的文本框
 */
@property (strong ,nonatomic) UILabel *goOnLabel;
/**
 *  去程的时间
 */
@property (strong ,nonatomic) UILabel *goOnTimeLabel;
/**
 *  返程的标志
 */
@property (strong ,nonatomic) UILabel *backMarkLabel;
/**
 *  返程的文字label
 */
@property (strong ,nonatomic) UILabel *backTextlabel;

@end

@implementation BackJourneyViewController

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
    [self setNavBarTitle:NSLocalizedString(@"backJourneyNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.goOnImageView];
    [self.view addSubview:self.goOnLabel];
    [self.view addSubview:self.flightTableView];
    [self.view addSubview:self.goOnTimeLabel];
    
    [self.view addSubview:self.backMarkLabel];
    [self.view addSubview:self.backTextlabel];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.goOnImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:18 * Balance_Heith];
    [self.goOnImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.goOnImageView autoSetDimension:ALDimensionHeight toSize:19 * Balance_Heith];
    [self.goOnImageView autoSetDimension:ALDimensionWidth toSize:19 * Balance_Heith];
    
    [self.goOnLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.goOnImageView withOffset:10];
    [self.goOnLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:1];
    [self.goOnLabel autoSetDimension:ALDimensionHeight toSize:33 * Balance_Heith];
    [self.goOnLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    
    
    /*-----------------------伟大的分割线-----------------------*/
    UIView *line = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:line];
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(55 * Balance_Heith, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [line autoSetDimension:ALDimensionHeight toSize:0.8];
    line.backgroundColor = UIColorFromRGB(0xe3e3e3);
    /*-----------------------伟大的分割线-----------------------*/
    
    [self.goOnTimeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.goOnImageView withOffset:10];
    [self.goOnTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:22 * Balance_Heith];
    [self.goOnTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.goOnTimeLabel autoSetDimension:ALDimensionHeight toSize:33 * Balance_Heith];
    
    [self.backMarkLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64.25 * Balance_Heith];
    [self.backMarkLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.backMarkLabel autoSetDimension:ALDimensionHeight toSize:19 * Balance_Heith];
    [self.backMarkLabel autoSetDimension:ALDimensionWidth toSize:19 * Balance_Heith];
    
    [self.backTextlabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.goOnImageView withOffset:10];
    [self.backTextlabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:55 * Balance_Heith + 1];
    [self.backTextlabel autoSetDimension:ALDimensionHeight toSize:37.5 * Balance_Heith];
    [self.backTextlabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
}

#pragma mark - tableview datasource and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FlightTableViewCell *cell = [FlightTableViewCell flightCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellID:@"cell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0f * Balance_Heith;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0f * Balance_Heith;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChoosePassengerViewController *vc = [[ChoosePassengerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  去程的小图标
 *
 *  @return
 */
- (UILabel *)goOnImageView{
    if (!_goOnImageView) {
        _goOnImageView = [[UILabel alloc] initForAutoLayout];
        _goOnImageView.text = @"去";
        _goOnImageView.textAlignment = NSTextAlignmentCenter;
        _goOnImageView.font = [UIFont systemFontOfSize:14];
        _goOnImageView.textColor = UIColorFromRGB(0x909090);
        _goOnImageView.layer.cornerRadius = 9.5 * Balance_Heith;
        _goOnImageView.layer.masksToBounds = YES;
        _goOnImageView.layer.borderColor = UIColorFromRGB(0x909090).CGColor;
        _goOnImageView.layer.borderWidth = 0.8;
    }
    return _goOnImageView;
}

- (UILabel *)goOnLabel{
    if (!_goOnLabel) {
        _goOnLabel = [[UILabel alloc] initForAutoLayout];
        _goOnLabel.textColor = UIColorFromRGB(0x909090);
        _goOnLabel.text = @"03-9  哈尔滨 ---> 北京";
        _goOnLabel.backgroundColor = [UIColor clearColor];
        _goOnLabel.font = [UIFont systemFontOfSize:16];
    }
    return _goOnLabel;
}

- (UILabel *)goOnTimeLabel{
    if (!_goOnTimeLabel) {
        _goOnTimeLabel = [[UILabel alloc] initForAutoLayout];
        _goOnTimeLabel.textColor = UIColorFromRGB(0x909090);
        _goOnTimeLabel.text = @"12:12 - 20:18  ¥1918.00";
        _goOnTimeLabel.backgroundColor = [UIColor clearColor];
        _goOnTimeLabel.font = [UIFont systemFontOfSize:16];
    }
    return _goOnTimeLabel;
}

/**
 *  tableview的初始化
 *
 *  @return
 */
- (UITableView *)flightTableView{
    if (!_flightTableView) {
        _flightTableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 90*Balance_Heith, SCREEN_WIDTH, SCREEN_HEIGHT - 90*Balance_Heith) style:UITableViewStyleGrouped];
        [_flightTableView registerClass:[FlightTableViewCell class] forCellReuseIdentifier:@"cell"];
        _flightTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        _flightTableView.delegate   = self;
        _flightTableView.dataSource = self;
    }
    return _flightTableView;
}

- (UILabel *)backMarkLabel{
    if (!_backMarkLabel) {
        _backMarkLabel = [[UILabel alloc] initForAutoLayout];
        _backMarkLabel.text = @"返";
        _backMarkLabel.textAlignment = NSTextAlignmentCenter;
        _backMarkLabel.font = [UIFont systemFontOfSize:14];
        _backMarkLabel.textColor = UIColorFromRGB(0x1a9ded);
        _backMarkLabel.layer.cornerRadius = 9.5 * Balance_Heith;
        _backMarkLabel.layer.masksToBounds = YES;
        _backMarkLabel.layer.borderColor = UIColorFromRGB(0x1a9ded).CGColor;
        _backMarkLabel.layer.borderWidth = 0.8;
    }
    return _backMarkLabel;
}

- (UILabel *)backTextlabel{
    if (!_backTextlabel) {
        _backTextlabel = [[UILabel alloc] initForAutoLayout];
        _backTextlabel.textColor = UIColorFromRGB(0x1a9ded);
        _backTextlabel.text = @"03-9  北京 ---> 哈尔滨";
        _backTextlabel.backgroundColor = [UIColor clearColor];
    }
    return _backTextlabel;
}

@end
