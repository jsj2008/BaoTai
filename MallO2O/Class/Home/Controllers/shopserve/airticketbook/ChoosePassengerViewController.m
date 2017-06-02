//
//  ChoosePassengerViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/11.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "ChoosePassengerViewController.h"

#import "AddPassengerViewController.h"

#import "ChoosePassengerTableViewCell.h"

#import "AddPesonModel.h"

#import "LoginViewController.h"

#import "DestineViewController.h"

@interface ChoosePassengerViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property (strong ,nonatomic) UITableView *choosePassengerTableView;

@property (retain ,nonatomic) NSMutableArray *tableViewArray;

// 存 p_id 的数组
@property (retain ,nonatomic) NSMutableArray *pArray;

@end

@implementation ChoosePassengerViewController
{
    BOOL isOK;
}
#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initData];
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
    [self initData];
    [self.choosePassengerTableView reloadData];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {

    __weak typeof(self)selfVC = self;
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"passenger_list"]; //192.168.1.66/baotaiapp_action/ac_reserve/passenger_list
    NSDictionary *dic = @{
                          @"app_key" :url,
                          @"u_id"    :[PersonInfoModel shareInstance].uID
                          };
    [SwpRequest swpPOST:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if ([resultObject[@"code"] integerValue] == 200) {
            selfVC.tableViewArray = [self modelArrayFromResultObject:resultObject[@"obj"]];
            [selfVC.choosePassengerTableView reloadData];
        }
        
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
    
}

- (NSMutableArray *)modelArrayFromResultObject:(NSMutableArray *)resultObject{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in resultObject) {
        AddPesonModel *model = [AddPesonModel init:dic];
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
    [self setRightButton];
}


/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"choosePassengerNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
//    self.navigationItem.rightBarButtonItem = [UZCommonMethod setButtonTitle:@"确定" andTitleSize:15 andTitleColor:[UIColor whiteColor]];
}

/**
 *  添加控件
 */
- (void) addUI {
    _pArray = [NSMutableArray new];
    [self.view addSubview:self.choosePassengerTableView];
}


/**
 *  设置导航栏右侧按钮
 */
- (void)setRightButton{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 34);
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [rightButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
    [rightButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateHighlighted];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}
// 右侧按钮的点击方法
- (void)clickRightButton{
    if (![self checkLogin]) {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }
    if (self.popBlock) {
        self.popBlock(self.pArray);
    }
//    DestineViewController *vc = [[DestineViewController alloc] init];
//    vc.p_idArray = self.pArray;
//    [self.navigationController popToViewController:vc animated:YES];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)popViewControllerArray:(Block_p)block{
    
    self.popBlock = block;
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChoosePassengerTableViewCell *cell = [ChoosePassengerTableViewCell choosePassengerCellOfTableView:tableView cellForRowAtIndexPath:indexPath cellIdentifier:@"cell"];
    
    cell.dataList = self.tableViewArray[indexPath.row];
    
    [cell getButtonAction:^{
       
        AddPassengerViewController *vc = [[AddPassengerViewController alloc] init];
        vc.personModel = cell.dataList;
        vc.type = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }];
    
    return cell;
}

//- (void)setChooseBody:(NSString *)chooseBody {
//    
//    self.chooseBody = chooseBody;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 60;
    }
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f * Balance_Heith;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        headerView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        [self headerAddBtn:headerView];
        return headerView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    ChoosePassengerTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    
    AddPesonModel *model = self.tableViewArray[indexPath.row];
    model.typ = !model.typ;
    [tableView reloadData];
    
    if (model.typ == YES) {
        
        [_pArray addObject:model.p_id];
    }else {
        [_pArray removeObject:model.p_id];
    }
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

// 删除单元格
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        __weak typeof(self)this = self;
        NSString *url = [SwpTools swpToolGetInterfaceURL:@"passenger_del"]; // 192.168.1.66/baotaiapp_action/ac_reserve/passenger_del
        NSDictionary *dic = @{
                              @"app_key"    :url,
                              @"u_id"       :[PersonInfoModel shareInstance].uID,
                              @"p_id"       :[_tableViewArray[indexPath.row] p_id],
                                  };
        [SwpRequest swpPOST:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
            if ([resultObject[@"code"] integerValue] == 200) {
                
                [this.tableViewArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
            
        }];
        
    }
    
}


/**
 *  tableview的头部添加按钮
 *
 *  @param headerView 头部view
 */
- (void)headerAddBtn:(UIView *)headerView{
    UIButton *addBtn = [[UIButton alloc] initForAutoLayout];
    [headerView addSubview:addBtn];
    [addBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [addBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [addBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [addBtn autoSetDimension:ALDimensionHeight toSize:40];
    
    [addBtn setTitle:NSLocalizedString(@"choosePassengerAddedOpportunityToPeople", nil) forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addBtn setTitleColor:UIColorFromRGB(0x1a9ded) forState:UIControlStateNormal];
    [addBtn setBackgroundColor:[UIColor whiteColor]];
    addBtn.layer.cornerRadius = 4;
    addBtn.layer.masksToBounds = YES;
    addBtn.layer.borderColor = UIColorFromRGB(0x1a9ded).CGColor;
    addBtn.layer.borderWidth = 0.8;
    [addBtn addTarget:self action:@selector(clickAddPassengerBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickAddPassengerBtn{
    AddPassengerViewController *vc = [[AddPassengerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 控件的懒加载
- (UITableView *)choosePassengerTableView{
    if (!_choosePassengerTableView) {
        _choosePassengerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60) style:UITableViewStyleGrouped];
        [_choosePassengerTableView registerClass:[ChoosePassengerTableViewCell class] forCellReuseIdentifier:@"cell"];
        _choosePassengerTableView.delegate = self;
        _choosePassengerTableView.dataSource = self;
        _choosePassengerTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    }
    return _choosePassengerTableView;
}

@end
