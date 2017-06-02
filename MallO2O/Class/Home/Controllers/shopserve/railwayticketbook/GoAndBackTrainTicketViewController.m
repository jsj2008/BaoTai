//
//  GoAndBackTrainTicketViewController.m
//  MallO2O
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "GoAndBackTrainTicketViewController.h"
#import "ChooseViewController.h"


/**航班列表的cell*/
#import "TrainTableViewCell.h"

@interface GoAndBackTrainTicketViewController ()<UITableViewDataSource ,UITableViewDelegate>

@property (strong ,nonatomic) UITableView *trainTableView;
/**
 *  去程的小图标
 */
@property (strong ,nonatomic) UILabel *goOnImageView;
/**
 *  去程的文本框
 */
@property (strong ,nonatomic) UILabel *goOnLabel;

@end

@implementation GoAndBackTrainTicketViewController

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
    [self setNavBarTitle:NSLocalizedString(@"backTrainNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.goOnImageView];
    [self.view addSubview:self.goOnLabel];
    [self.view addSubview:self.trainTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.goOnImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:9.25 * Balance_Heith];
    [self.goOnImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.goOnImageView autoSetDimension:ALDimensionHeight toSize:19 * Balance_Heith];
    [self.goOnImageView autoSetDimension:ALDimensionWidth toSize:19 * Balance_Heith];
    
    [self.goOnLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.goOnImageView withOffset:10];
    [self.goOnLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:1];
    [self.goOnLabel autoSetDimension:ALDimensionHeight toSize:37.5 * Balance_Heith];
    [self.goOnLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
}

#pragma mark - tableview datasource and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TrainTableViewCell *cell = [TrainTableViewCell trainCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellID:@"cell"];
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
    ChooseViewController *viewController = [[ChooseViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
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
        _goOnImageView.textColor = UIColorFromRGB(0x1a9ded);
        _goOnImageView.layer.cornerRadius = 9.5 * Balance_Heith;
        _goOnImageView.layer.masksToBounds = YES;
    }
    return _goOnImageView;
}

- (UILabel *)goOnLabel{
    if (!_goOnLabel) {
        _goOnLabel = [[UILabel alloc] initForAutoLayout];
        _goOnLabel.textColor = UIColorFromRGB(0x1a9ded);
        _goOnLabel.text = @"03-9  哈尔滨 ---> 拉萨";
        _goOnLabel.backgroundColor = [UIColor clearColor];
        _goOnImageView.layer.borderColor = UIColorFromRGB(0x1a9ded).CGColor;
        _goOnImageView.layer.borderWidth = 0.8;
    }
    return _goOnLabel;
}

/**
 *  tableview的初始化
 *
 *  @return
 */
- (UITableView *)trainTableView{
    if (!_trainTableView) {
        _trainTableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 37.5*Balance_Heith, SCREEN_WIDTH, SCREEN_HEIGHT - 37.5*Balance_Heith) style:UITableViewStyleGrouped];
        [_trainTableView registerClass:[TrainTableViewCell class] forCellReuseIdentifier:@"cell"];
        _trainTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        _trainTableView.delegate   = self;
        _trainTableView.dataSource = self;
    }
    return _trainTableView;
}

@end
