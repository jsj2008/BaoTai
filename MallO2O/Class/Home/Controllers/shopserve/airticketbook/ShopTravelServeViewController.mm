//
//  ShopTravelServeViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/10.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "ShopTravelServeViewController.h"

#import "LoginViewController.h"

#import <Masonry/Masonry.h>

#import "UPPaymentControl.h"

#import "PlaneBookViewController.h"
#import "RailwayTicketBookViewController.h"
#import "InvitationServerViewController.h"
#import "HotboomServeViewController.h"
#import "CarServerViewController.h"
#import "CateGoodsViewController.h"
#import "BigTradeViewController.h"

#import "STModal.h"

#import "AgreementView.h"

#import "ShopTravelServerModel.h"
#import "PriceModel.h"

@interface ShopTravelServeViewController ()<UITableViewDataSource ,UITableViewDelegate>

@property (strong ,nonatomic) UITableView *shopTravelServeTableView;

@property (copy ,nonatomic) NSArray *dataArray;

@end

@implementation ShopTravelServeViewController{
    NSMutableData* _responseData;
    NSArray *_serviceUrlArr;
    NSDictionary *_serviceUrlDic;
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
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
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
    
    ShopTravelServerModel *model1 = [ShopTravelServerModel setModelVCName:@"PlaneBookViewController" andImageName:@"shop_travle_1" andServerName:NSLocalizedString(@"shopTravelServeAirTicketBookingTitle", nil)];
    ShopTravelServerModel *model2 = [ShopTravelServerModel setModelVCName:@"RailwayTicketBookViewController" andImageName:@"shop_travle_2" andServerName:NSLocalizedString(@"shopTravelServeTrainTicketReservationTitle", nil)];
    ShopTravelServerModel *model3 = [ShopTravelServerModel setModelVCName:@"InvitationServerViewController" andImageName:@"shop_travle_3" andServerName:NSLocalizedString(@"shopTravelServeInvitationServiceTitle", nil)];
    ShopTravelServerModel *model4 = [ShopTravelServerModel setModelVCName:@"CarServerViewController" andImageName:@"shop_travle_4" andServerName:NSLocalizedString(@"shopTravelServePick-upServiceTitle", nil)];
    ShopTravelServerModel *model5 = [ShopTravelServerModel setModelVCName:@"HotboomServeViewController" andImageName:@"shop_travle_5" andServerName:NSLocalizedString(@"shopTravelServePurchasingServiceTitle", nil)];
    ShopTravelServerModel *model6 = [ShopTravelServerModel setModelVCName:@"CateGoodsViewController" andImageName:@"shop_travle_6" andServerName:NSLocalizedString(@"shopTravelServeHotelsTitle", nil)];
    model6.serverID = @"2";
    ShopTravelServerModel *model7 = [ShopTravelServerModel setModelVCName:@"CateGoodsViewController" andImageName:@"shop_travle_7" andServerName:NSLocalizedString(@"shopTravelServeDiningReservationsTitle", nil)];
    model7.serverID = @"3";
    _dataArray = @[model1,model2,model3,model4,model5,model6,model7];
    _serviceUrlArr = [NSArray new];
    _serviceUrlDic = [NSDictionary new];
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
    [self setNavBarTitle:NSLocalizedString(@"shopTravelServeNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.shopTravelServeTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

#pragma mark - tableview  datasource and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopServeCell" forIndexPath:indexPath];
    ShopTravelServerModel *model = self.dataArray[indexPath.section];
    cell.imageView.image = [UIImage imageNamed:model.imageName];
    cell.textLabel.text = model.serverName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setCellUI:cell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (void)setCellUI:(UITableViewCell *)cell{
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = UIColorFromRGB(0x555555);
    [cell.imageView setFrame:CGRectMake(15, 13, 14, 14)];
}

#pragma mark - connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
    NSInteger code = [rsp statusCode];
    if (code != 200)
    {
//        [self showAlertMessage:kErrorNet];
        [connection cancel];
    }
    else
    {
        _responseData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    [self hideAlert];
    NSString* tn = [[NSMutableString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    if (tn != nil && tn.length > 0)
    {
        NSLog(@"tn=%@",tn);
        [[UPPaymentControl defaultControl] startPay:tn fromScheme:@"MallO2O" mode:@"01" viewController:self];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopTravelServerModel *model = self.dataArray[indexPath.section];
    __weak typeof(self) vc = self;
//    NSURLRequest * urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://101.231.204.84:8091/sim/getacptn"]];
//    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
//    [urlConn start];
    NSString *url = [NSString stringWithFormat:@"http://%@/app_action/ac_service_agreement/service_agreement",baseUrl];
//    NSString *url = @"http://baotai.youzhiapp.com/app_action/ac_service_agreement/service_agreement";
    NSDictionary *dic = @{
                          @"app_key" : url
                          };
    AgreementView *view = [[AgreementView alloc] init];
    STModal *stmodel = [STModal modalWithContentView:view];
    stmodel.hideWhenTouchOutside = YES;
    [stmodel show:YES];
    [SwpRequest swpPOST:url parameters:dic isEncrypt:[SwpNetworkModel shareInstance].swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@",resultObject);
        
        view.backgroundColor = [UIColor whiteColor];
        _serviceUrlArr = resultObject[@"obj"][@"service_agreement_url"];
        NSLog(@"%@",_serviceUrlArr);
        _serviceUrlDic = _serviceUrlArr[indexPath.section];
        view.webUrl = _serviceUrlDic[@"service_url"];
        
        NSLog(@"%@",view.webUrl);
        
        [PriceModel savePrice:resultObject[@"obj"]];
        
        [view setClickButtonBlock:^{
            [stmodel hide:YES];
            if ([model.viewControllerName isEqualToString:@"CateGoodsViewController"]) {
                BigTradeViewController *viewController = [[BigTradeViewController alloc] init];
                viewController.listType = model.serverID;
                viewController.navigationTitle = model.serverName;
                [vc.navigationController pushViewController:viewController animated:YES];
                return ;
            }
            if (model.viewControllerName != nil && ![model.viewControllerName isEqualToString:@""]) {
                
//                if (![self checkLogin]) {
//                    LoginViewController *viewController = [[LoginViewController alloc] init];
//                    [viewController setBackButton];
//                    [self.navigationController pushViewController:viewController animated:YES];
//                    return;
//                }
                
                [vc.navigationController pushViewController:[[NSClassFromString(model.viewControllerName) alloc] init] animated:YES];
            }
        }];
        [view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(100, 30, 70, 30) excludingEdge:ALEdgeBottom];
        [view autoSetDimension:ALDimensionHeight toSize:300 * Balance_Heith];
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

/**
 *  tableview 的懒加载
 *
 *  @return
 */
- (UITableView *)shopTravelServeTableView{
    if (!_shopTravelServeTableView) {
        _shopTravelServeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        [_shopTravelServeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"shopServeCell"];
        _shopTravelServeTableView.delegate = self;
        _shopTravelServeTableView.dataSource = self;
    }
    return _shopTravelServeTableView;
}

- (void)dealloc{
    NSLog(@";D :D ;D");
}

@end
