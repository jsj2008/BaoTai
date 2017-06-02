//
//  SeeGoodsHistoryViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/28.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "SeeGoodsHistoryViewController.h"

#import "GoodsWebViewController.h"

#import "MiaoTableViewCell.h"

#import "SeeGoodsHistoryModel.h"

@interface SeeGoodsHistoryViewController ()<UITableViewDataSource ,UITableViewDelegate>

@property (strong ,nonatomic) UITableView *historySeeTableView;

@property (strong ,nonatomic) NSMutableArray *tableViewArray;

@end

@implementation SeeGoodsHistoryViewController{
    int page;
}

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
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    page = 1;
    self.tableViewArray = [NSMutableArray array];
    [self getHistoryData];
}

- (void)getHistoryData{
    NSString *url = @"http://baotai.youzhiapp.com/app_action/ac_user_history/history_list";
  
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"u_id"    : [PersonInfoModel shareInstance].uID
                          };
    [SwpRequest swpPOST:url parameters:dic isEncrypt:[SwpNetworkModel shareInstance].swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        
        if ([resultObject[@"code"] integerValue] == 200) {
            self.tableViewArray = [self arrayWithDicArray:resultObject[@"obj"]];
            [self.historySeeTableView reloadData];
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

/**
 *  网络数据转模型数组
 *
 *  @param param 网络数据
 *
 *  @return 模型数组
 */
- (NSMutableArray *)arrayWithDicArray:(NSMutableArray *)param{
    NSMutableArray *array = [NSMutableArray array];
//    if (page != 1) {
//        array = self.tableViewArray;
//    }
    for (NSDictionary *dic in param) {
        SeeGoodsHistoryModel *model = [SeeGoodsHistoryModel arrayWithDic:dic];
//        [array addObject:model];
        [array addObject:model];
    }
    return array;
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
    [self setNavBarTitle:NSLocalizedString(@"mineHistoryGoods", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 34);
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [rightButton setTitle:NSLocalizedString(@"seeGoodsHistoryViewControllerClearInfo", nil) forState:UIControlStateNormal];
    [rightButton setTitle:NSLocalizedString(@"seeGoodsHistoryViewControllerClearInfo", nil) forState:UIControlStateHighlighted];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)clickRightButton{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"del_history"];
    NSDictionary *dic = @{
                          @"app_key" : url,
                          @"u_id"    : [PersonInfoModel shareInstance].uID
                          };
    [SwpRequest swpPOST:url parameters:dic isEncrypt:[SwpNetworkModel shareInstance].swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if ([resultObject[@"code"] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"seeGoodsHistoryViewControllerSuccessInfo", nil)];
            [self.tableViewArray removeAllObjects];
            [self.historySeeTableView reloadData];
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.historySeeTableView];
    [self.historySeeTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

#pragma mark - uitableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MiaoTableViewCell *cell = [MiaoTableViewCell secondeCellWithTableView:tableView cellForRowAtIndex:indexPath];
    [UZCommonMethod settingTableViewAllCellWire:_historySeeTableView andTableViewCell:cell];
    cell.secondModel = _tableViewArray[indexPath.row];
    NSLog(@"%@",_tableViewArray);
    return cell;
}

//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83.5f * Balance_Heith;
}
//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
    SeeGoodsHistoryModel *model = _tableViewArray[indexPath.row];
    viewController.webTitle = NSLocalizedString(@"productDetailsNavigationTitle", nil);
    viewController.webViewUrl = model.webUrl;
    viewController.shopName = model.secondTitleText;
    viewController.imageUrl = model.secondImgUrlText;
    [self.navigationController pushViewController:viewController animated:YES];
}


- (UITableView *)historySeeTableView{
    if (!_historySeeTableView) {
        _historySeeTableView = [[UITableView alloc] initForAutoLayout];
        _historySeeTableView.delegate = self;
        _historySeeTableView.dataSource = self;
        [UZCommonMethod hiddleExtendCellFromTableview:_historySeeTableView];
//        [self swpPublicToolSettingTableViewRefreshing:_historySeeTableView target:self headerAction:@selector(refreshingHeaderData) footerAction:@selector(refreshingFooterData)];
    }
    return _historySeeTableView;
}

#pragma mark 上拉加载和下拉刷新
- (void)refreshingHeaderData{
    page = 1;
    [self.historySeeTableView.mj_footer setState:MJRefreshStateIdle];
    [self getHistoryData];
    [_historySeeTableView.mj_header endRefreshing];
}

- (void)refreshingFooterData{
    page ++;
    [self getHistoryData];
    [_historySeeTableView.mj_footer endRefreshing];
    [_historySeeTableView.mj_footer endRefreshing];
}

@end
