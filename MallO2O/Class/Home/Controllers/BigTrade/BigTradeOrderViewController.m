//
//  BigTradeOrderViewController.m
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeOrderViewController.h"


/*! ---------------------- Tool       ---------------------- !*/
#import "SwpWeakifyHeader.h"
/*! ---------------------- Tool       ---------------------- !*/

/*! ---------------------- Controller ---------------------- !*/
#import "AdressDetailController.h"
#import "BigTradeOrderSeccessViewController.h"
/*! ---------------------- Controller ---------------------- !*/

/*! ---------------------- View       ---------------------- !*/
#import "BigTradeOrderShopInfoCell.h"
#import "BigTradeOrderAddressCell.h"
#import "BigTradeOrderRemarksCell.h"
/*! ---------------------- View       ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/
#import "BigTradeOrderGroupModel.h"
#import "BigTradeOrderShopInfoModel.h"
#import "BigTradeOrderAddressModel.h"
#import "BigTradeOrderRemarksModel.h"
/*! ---------------------- Model      ---------------------- !*/




static NSString * const kBigTradeOrderShopInfoCellID = @"kBigTradeOrderShopInfoCellID";
static NSString * const kBigTradeOrderAddressCellID  = @"kBigTradeOrderAddressCellID";
static NSString * const kBigTradeOrderRemarksCellID  = @"kBigTradeOrderRemarksCellID";

@interface BigTradeOrderViewController () <UITableViewDataSource, UITableViewDelegate>



#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
@property (nonatomic, weak) IBOutlet UITableView *bigTradeOrderTableView;
@property (nonatomic, weak) IBOutlet UILabel     *bigTradeOrderMoneyTitleView;
@property (nonatomic, weak) IBOutlet UILabel     *bigTradeOrderMoneyView;
@property (nonatomic, weak) IBOutlet UIButton    *bigTradeOrderCommitButton;
/*! ---------------------- UI   Property  ---------------------- !*/

#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
@property (nonatomic, copy) NSArray  *bigTradeOrderArray;
@property (nonatomic, copy) NSString *bigTradeOrderRemarksText;
@property (nonatomic, copy) NSString *bigTradeOrderAddressInfo;
@property (nonatomic, copy) NSString *bigTradeOrderTel;
/*! ---------------------- Data Property  ---------------------- !*/


@end

@implementation BigTradeOrderViewController

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
    self.bigTradeOrderRemarksText = @"";
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
    [self settingData];
    
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
    
    
    self.bigTradeOrderAddressInfo = [GetUserDefault(Address) objectForKey:@"address_info"];
    self.bigTradeOrderTel         = [GetUserDefault(Address) objectForKey:@"phone_tel"];
//    BigTradeOrderAddressModel  *bigTradeOrderAddress  = [BigTradeOrderAddressModel bigTradeOrderAddressWithTitle:[GetUserDefault(Address) objectForKey:@"consignee"] subTitle:[NSString stringWithFormat:@"%@ %@", [GetUserDefault(Address) objectForKey:@"address_info"], [GetUserDefault(Address) objectForKey:@"phone_tel"]]];
    
    BigTradeOrderAddressModel  *bigTradeOrderAddress  = [BigTradeOrderAddressModel bigTradeOrderAddressWithTitle:[GetUserDefault(Address) objectForKey:@"consignee"] subTitle:[NSString stringWithFormat:@"%@ %@",self.bigTradeOrderAddressInfo, self.bigTradeOrderTel]];
    BigTradeOrderGroupModel    *address               = [BigTradeOrderGroupModel bigTradeOrderGroupModelWithTitle:NSLocalizedString(@"bigTradeOrderReceiptAddressTitle", nil) bigTradeOrderDataSource:@[bigTradeOrderAddress]];
    
    BigTradeOrderShopInfoModel *bigTradeOrderShopInfo = [BigTradeOrderShopInfoModel bigTradeOrderShopInfoWithTitle:self.shopInfo[@"goods_name"] subTitle:[NSString stringWithFormat:@"x%@", self.shopInfo[@"g_num"]]];
    BigTradeOrderGroupModel    *commodityInformation  = [BigTradeOrderGroupModel bigTradeOrderGroupModelWithTitle:NSLocalizedString(@"bigTradeOrderCommodityInformationTitle", nil) bigTradeOrderDataSource:@[bigTradeOrderShopInfo]];
    
    BigTradeOrderRemarksModel *bigTradeOrderRemarks   = [BigTradeOrderRemarksModel bigTradeOrderRemarksWithPlaceholder:NSLocalizedString(@"bigTradeOrderRemarksPlaceholder", nil)];
    BigTradeOrderGroupModel   *remarkInformation      = [BigTradeOrderGroupModel bigTradeOrderGroupModelWithTitle:NSLocalizedString(@"bigTradeOrderRemarkInformationTitle", nil) bigTradeOrderDataSource:@[bigTradeOrderRemarks]];
    _bigTradeOrderArray = @[address, commodityInformation, remarkInformation];
    [self.bigTradeOrderTableView reloadData];
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
    [self setNavBarTitle:NSLocalizedString(@"bigTradeOrderNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
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
    [_bigTradeOrderCommitButton setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateNormal];
    _bigTradeOrderMoneyTitleView.text  = NSLocalizedString(@"bigTradeOrderMoneyTitle", nil);
    _bigTradeOrderMoneyView.text       = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"Money", nil), self.shopInfo[@"total_price"]];
    _bigTradeOrderTableView.dataSource = self;
    _bigTradeOrderTableView.delegate   = self;
    
    [_bigTradeOrderTableView registerClass:[BigTradeOrderAddressCell class] forCellReuseIdentifier:kBigTradeOrderAddressCellID];
    [_bigTradeOrderTableView registerClass:[BigTradeOrderShopInfoCell class] forCellReuseIdentifier:kBigTradeOrderShopInfoCellID];
    [_bigTradeOrderTableView registerClass:[BigTradeOrderRemarksCell class] forCellReuseIdentifier:kBigTradeOrderRemarksCellID];
}

- (IBAction)cleckButton:(UIButton *)button {
    [self commmitOrederData];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.bigTradeOrderArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BigTradeOrderGroupModel *bigTradeOrderGroup = self.bigTradeOrderArray[section];
    return bigTradeOrderGroup.bigTradeOrderGroupDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    BigTradeOrderGroupModel *bigTradeOrderGroup = self.bigTradeOrderArray[indexPath.section];

    if ([bigTradeOrderGroup.bigTradeOrderGroupDataSource[indexPath.row] isKindOfClass:[BigTradeOrderRemarksModel class]]) {
        BigTradeOrderRemarksCell *cell = [BigTradeOrderRemarksCell bigTradeOrderRemarksCellTableView:tableView forCellReuseIdentifier:kBigTradeOrderRemarksCellID];
        cell.bigTradeOrderRemarks = bigTradeOrderGroup.bigTradeOrderGroupDataSource[indexPath.row];
        [self bigTradeOrderRemarksCellChangeText:cell];
        return cell;
    }
    
    if ([bigTradeOrderGroup.bigTradeOrderGroupDataSource[indexPath.row] isKindOfClass:[BigTradeOrderAddressModel class]]) {
        
        BigTradeOrderAddressCell *cell = [BigTradeOrderAddressCell bigTradeOrderAddressCellTableView:tableView forCellReuseIdentifier:kBigTradeOrderAddressCellID];
        cell.bigTradeOrderAddress      = bigTradeOrderGroup.bigTradeOrderGroupDataSource[indexPath.row];
        
        return cell;
    }
    
    
    BigTradeOrderShopInfoCell *cell = [BigTradeOrderShopInfoCell bigTradeOrderShopInfoCellWithTableView:tableView forCellReuseIdentifier:kBigTradeOrderShopInfoCellID];
    cell.bigTradeOrderShopInfo = bigTradeOrderGroup.bigTradeOrderGroupDataSource[indexPath.row];
    return cell;

}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 29.99;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BigTradeOrderGroupModel *bigTradeOrderGroup = self.bigTradeOrderArray[indexPath.section];
    if ([bigTradeOrderGroup.bigTradeOrderGroupDataSource[indexPath.row] isKindOfClass:[BigTradeOrderRemarksModel class]]) {
        return [SwpTools swpToolScreenScale:[SwpTools swpToolScreenWidth] scaleWidth:2.0 scaleHeight:1.0];
    }
    
    if ([bigTradeOrderGroup.bigTradeOrderGroupDataSource[indexPath.row] isKindOfClass:[BigTradeOrderAddressModel class]]) {
        return 60;
    }
    
    
    return 37;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BigTradeOrderGroupModel *bigTradeOrderGroup = self.bigTradeOrderArray[indexPath.section];
    if ([bigTradeOrderGroup.bigTradeOrderGroupDataSource[indexPath.row] isKindOfClass:[BigTradeOrderAddressModel class]]) {
        UIStoryboard *story        = [UIStoryboard storyboardWithName:@"Address" bundle:[NSBundle mainBundle]];
        AdressDetailController *vc = [story instantiateViewControllerWithIdentifier:@"adress"];
        vc.isSelectAddress         = @"YES";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    BigTradeOrderGroupModel *bigTradeOrderGroup = self.bigTradeOrderArray[section];
    return bigTradeOrderGroup.bigTradeOrderGroupHeaderTitle;
}

- (void)bigTradeOrderRemarksCellChangeText:(BigTradeOrderRemarksCell *)cell {
    
    @swpWeakify(self);
    [cell bigTradeOrderRemarksCellChangeText:^(NSString * _Nonnull changeText) {
        @swpStrongify(self);
        self.bigTradeOrderRemarksText = changeText;
    }];
}


- (void)commmitOrederData {

    NSString            *url        = [SwpTools swpToolGetInterfaceURL:@"order_insert"];
    NSDictionary        *dictionary = @{
                                        @"app_key"      : url,
                                        @"g_num"        : [NSString stringWithFormat:@"%@", self.shopInfo[@"g_num"]],
                                        @"goods_id"     : [NSString stringWithFormat:@"%@", self.shopInfo[@"goods_id"]],
                                        @"goods_name"   : [NSString stringWithFormat:@"%@", self.shopInfo[@"goods_name"]],
                                        @"spec"         : [NSString stringWithFormat:@"%@", self.shopInfo[@"spec"]],
                                        @"total_price"  : [NSString stringWithFormat:@"%@", self.shopInfo[@"total_price"]],
                                        @"u_id"         : [PersonInfoModel shareInstance].uID,
                                        @"mobile"       : self.bigTradeOrderTel,
                                        @"address"      : self.bigTradeOrderAddressInfo,
                                        @"consignee"    : [GetUserDefault(Address) objectForKey:@"consignee"],
                                        @"remark"       : self.bigTradeOrderRemarksText == nil | [SwpTools swpToolTrimString:self.bigTradeOrderRemarksText].length == 0 ? @"0" : self.bigTradeOrderRemarksText,
                                        };
    [self swpPublicTooGetDataToServer:url parameters:dictionary isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        [self.navigationController pushViewController:[BigTradeOrderSeccessViewController new] animated:YES];
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}


- (NSArray *)bigTradeOrderArray {
    
    if (!_bigTradeOrderArray) {
        
        
        _bigTradeOrderArray = [NSArray array];
        
    }
    return _bigTradeOrderArray;
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
