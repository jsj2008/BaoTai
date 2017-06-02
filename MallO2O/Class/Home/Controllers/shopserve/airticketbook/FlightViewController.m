//
//  FlightViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/10.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "FlightViewController.h"

#import "FlightTableViewCell.h"

#import "ChoosePassengerViewController.h"



@interface FlightViewController ()<UITableViewDataSource ,UITableViewDelegate>

/**
 *  航班列表
 */
@property (strong ,nonatomic) UITableView *flightTableView;
/**
 *  显示城市到达地点
 */
@property (strong ,nonatomic) UILabel     *cityLabel;

@end

@implementation FlightViewController

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
    [self.view addSubview:self.cityLabel];
    [self.view addSubview:self.flightTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.cityLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 20, 0, 20) excludingEdge:ALEdgeBottom];
    [self.cityLabel autoSetDimension:ALDimensionHeight toSize:37.5 * Balance_Heith];
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

#pragma mark - 控件懒加载
/**
 *  城市label
 *
 *  @return
 */
- (UILabel *)cityLabel{
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] initForAutoLayout];
        self.cityLabel.text = @"03-9  哈尔滨 ---> 北京";
        self.cityLabel.textColor = UIColorFromRGB(0x1a9ded);
        self.cityLabel.backgroundColor = [UIColor clearColor];
    }
    return _cityLabel;
}
/**
 *  航班列表
 *
 *  @return
 */
- (UITableView *)flightTableView{
    if (!_flightTableView) {
        _flightTableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 37.5*Balance_Heith, SCREEN_WIDTH, SCREEN_HEIGHT - 37.5*Balance_Heith) style:UITableViewStyleGrouped];
        [_flightTableView registerClass:[FlightTableViewCell class] forCellReuseIdentifier:@"cell"];
        _flightTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        _flightTableView.delegate   = self;
        _flightTableView.dataSource = self;
    }
    return _flightTableView;
}

@end
