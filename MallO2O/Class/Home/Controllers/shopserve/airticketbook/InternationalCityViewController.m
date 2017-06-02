//
//  InternationalCityViewController.m
//  MallO2O
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "InternationalCityViewController.h"

#import "CityModel.h"

@interface InternationalCityViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) UITableView *cityTableView;

@property (copy   ,nonatomic) NSMutableArray *tableViewArray;

@end

@implementation InternationalCityViewController

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
    [self getCityFromNet];
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
    [self setNavBarTitle:NSLocalizedString(@"InternationalCityNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.cityTableView];
}

#pragma mark - 获取网络数据
- (void)getCityFromNet{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"city_list"];//@"http://192.168.1.66/baotai/app_action/ac_nationality/nationality_list";
    NSDictionary *dic = @{
                          @"app_key" : url
                          };
    
    
    [SwpRequest swpPOST:url parameters:dic isEncrypt:[SwpNetworkModel shareInstance].swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        
        if ([resultObject[@"code"] integerValue] == 200) {
            self.tableViewArray = [self modelArrayFromResultObject:resultObject[@"obj"]];
            [self.cityTableView reloadData];
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"%@",error);
    }];
}

- (NSMutableArray *)modelArrayFromResultObject:(NSMutableArray *)resultObject{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in resultObject) {
        CityModel *model = [CityModel init:dic];
        [array addObject:model];
    }
    return array;
}



/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.cityTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
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
    CityModel *model = self.tableViewArray[indexPath.row];
    NSLog(@"===============%@",model.cityName);
    cell.textLabel.text = model.cityName;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UZCommonMethod settingTableViewAllCellWire:tableView andTableViewCell:cell];
    return cell;
}

- (void)getCityNameAndCityID:(InternationalCityBlock)block {
    
    self.internationalCityBlock = block;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityModel *model = self.tableViewArray[indexPath.row];
    if (self.internationalCityBlock) {
        self.internationalCityBlock(model.cityName ,model.cityID);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 控件加载
- (UITableView *)cityTableView{
    if (!_cityTableView) {
        _cityTableView = [[UITableView alloc] initForAutoLayout];
        [_cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
        [UZCommonMethod hiddleExtendCellFromTableview:_cityTableView];
    }
    return _cityTableView;
}


@end
