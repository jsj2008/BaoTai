//
//  NationalityCountryViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "NationalityCountryViewController.h"

#import "CountryModel.h"

@interface NationalityCountryViewController ()<UITableViewDataSource ,UITableViewDelegate>

@property (strong ,nonatomic) UITableView *nationalityTableView;

@property (copy   ,nonatomic) NSMutableArray *tableViewArray;

@end

@implementation NationalityCountryViewController

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
    
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    [self getCountryFromNet];
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
    [self setNavBarTitle:NSLocalizedString(@"invitationServerCountryCitizenshipTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.nationalityTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.nationalityTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma mark - 获取网络数据
- (void)getCountryFromNet{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"nationality_list"];//@"http://192.168.1.66/baotai/app_action/ac_nationality/nationality_list";
    NSDictionary *dic = @{
                          @"app_key" : url
                          };
    [SwpRequest swpPOST:url parameters:dic isEncrypt:[SwpNetworkModel shareInstance].swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if ([resultObject[@"code"] integerValue] == 200) {
            self.tableViewArray = [self modelArrayFromResultObject:resultObject[@"obj"]];
            [self.nationalityTableView reloadData];
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"%@",error);
    }];
}

- (NSMutableArray *)modelArrayFromResultObject:(NSMutableArray *)resultObject{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in resultObject) {
        CountryModel *model = [CountryModel init:dic];
        [array addObject:model];
    }
    return array;
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CountryModel *model = self.tableViewArray[indexPath.row];
    cell.textLabel.text = model.coutryName;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

- (void)getCountryNameAndCountryID:(NationalVCBlock)block{
    self.nationalBlock = block;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CountryModel *model = self.tableViewArray[indexPath.row];
    if (self.nationalBlock) {
        self.nationalBlock(model.coutryName ,model.coutryID);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 控件加载
- (UITableView *)nationalityTableView{
    if (!_nationalityTableView) {
        _nationalityTableView = [[UITableView alloc] initForAutoLayout];
        [_nationalityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _nationalityTableView.delegate = self;
        _nationalityTableView.dataSource = self;
        [UZCommonMethod hiddleExtendCellFromTableview:_nationalityTableView];
    }
    return _nationalityTableView;
}

@end
