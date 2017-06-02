//
//  PushOrderViewController.m
//  MallO2O
//
//  Created by mac on 15/6/17.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "PushOrderViewController.h"
#import "PushAddressTableViewCell.h"
#import "PushOrderBTableViewCell.h"

#import "PayPalMobile.h"

#import "PushPayTableViewCell.h"
#import "PointNumTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "OrderMarkModel.h"
#import "InputMarkMessageViewController.h"
#import "GoodsWebViewController.h"
#import "OrderDetailViewController.h"
#import "PushOrderSuccessViewController.h"
#import "AdressDetailController.h"

#import "WXApi.h"
#import "payRequsestHandler.h"
#import "WechatOrderInformation.h"

#import "UPPaymentControl.h"
#import "ShoppingCartViewController.h"
#import "Pingpp.h"
#import "PingppURLResponse.h"

static NSString *cellID = @"pushOrderCell";

@interface PushOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,WXApiDelegate,PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate, UIPopoverControllerDelegate>

@property (strong ,nonatomic) UITableView *orderTableView;

@property (strong ,nonatomic) UIDatePicker *datePicker;

@property (strong ,nonatomic) UILabel *totalLabel;

@property (strong ,nonatomic) UILabel *totalMoneyLabel;

@property (strong ,nonatomic) UIButton *commitButton;

@property (strong ,nonatomic) UIView *commitView;

@property (strong ,nonatomic) PersonInfoModel *personInfoModel;

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@property(nonatomic, strong, readwrite) NSString *environment;

@end

@implementation PushOrderViewController{
    NSString *dateString;
    NSIndexPath *selectIndex;
    NSIndexPath *pointNumIndex;
    NSArray *payArray;
    NSMutableDictionary *dic;
    NSString *pointString;
    NSMutableDictionary *songhuoDic;
    int payMode;
    NSDictionary *alipayOrderDic;
    NSString *payTypeName;
    NSString *pointNumber;
    NSArray *payMarkArray;
    NSString *orderId;
}

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"%@",GetUserDefault(Person_Info));
    [self initData];
    [self initUI];
    [self setPayPalsConfig];
    NSLog(@"%@",_shopCarArray[5]);
}

- (void)setPayPalsConfig{
    _payPalConfig = [[PayPalConfiguration alloc] init];
#if HAS_CARDIO
    // You should use the PayPal-iOS-SDK+card-Sample-App target to enable this setting.
    // For your apps, you will need to link to the libCardIO and dependent libraries. Please read the README.md
    // for more details.
    _payPalConfig.acceptCreditCards = YES;
#else
    _payPalConfig.acceptCreditCards = NO;
#endif
    _payPalConfig.merchantName = @"Awesome Shirts, Inc.";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    self.environment = PayPalEnvironmentNoNetwork;
}

- (BOOL)acceptCreditCards {
    return self.payPalConfig.acceptCreditCards;
}

- (void)setAcceptCreditCards:(BOOL)acceptCreditCards {
    self.payPalConfig.acceptCreditCards = acceptCreditCards;
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
    [self.navigationController setNavigationBarHidden:NO];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    [_orderTableView reloadData];
    _commitButton.enabled = YES;
}


#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    orderId = [NSString string];
    /**
        列表显示的一些东西  顺序有点乱
     */
    self.personInfoModel = [PersonInfoModel shareInstance];
    pointNumber = [[NSString alloc] init];
    payTypeName = [[NSString alloc] init];
    payTypeName = @"支付宝";
    alipayOrderDic = [[NSDictionary alloc] init];
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"优 惠" forKey:@"typeName"];
    [dic setValue:@"0元" forKey:@"typeDetail"];
    songhuoDic = [[NSMutableDictionary alloc] init];
    [songhuoDic setValue:NSLocalizedString(@"pushOrderCellTimePlaceholder", nil) forKey:@"typeName"];
    pointNumIndex = [[NSIndexPath alloc] init];
    selectIndex = [[NSIndexPath alloc] init];
    payArray = @[NSLocalizedString(@"pushOrderCellPlaceHolderPaymentUnionpay", nil), NSLocalizedString(@"pushOrderCellPlaceholderPaymentPaymentInCash", nil)];
    payMarkArray = @[@"paypal",@"pay_arrive"];
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ccc:) name:@"aaa" object:nil];
}

- (void)ccc:(NSNotification *)notify{
    NSLog(@"%@",notify);
    NSString *code = notify.object;
    if ([code isEqualToString:@"fail"]) {
        
    }
    if ([code isEqualToString:@"cancle"]) {
        
    }
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"pushOrderNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.orderTableView];
    [self.view addSubview:self.commitView];
    [_commitView addSubview:self.totalLabel];
    [_commitView addSubview:self.totalMoneyLabel];
    [_commitView addSubview:self.commitButton];
}

/**
 重写返回方法
 */
- (void)popViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 提交订单部分
/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    /**
        ui细节
     */
    /**view里的控件*/
    [_commitView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_commitView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_commitView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_commitView autoSetDimension:ALDimensionHeight toSize:46];
    _commitView.layer.borderWidth = 0.6;
    _commitView.layer.borderColor = UIColorFromRGB(0xd9d9d9).CGColor;
    /**view里的控件*/
    
    [_totalLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_totalLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_totalLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_totalLabel sizeToFit];
    _totalMoneyLabel.text = [NSString stringWithFormat:@"%@%0.2f",NSLocalizedString(@"Money", nil),[_shopCarArray[0] floatValue] + [_shopCarArray[1] floatValue]];
    _totalLabel.text = NSLocalizedString(@"pushOrderUserAmountPaid", nil);

    /**
        总金额数  从购物车web页获取
     */
    [_totalMoneyLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_totalMoneyLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_totalMoneyLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_totalLabel withOffset:3];
    [_totalMoneyLabel autoSetDimension:ALDimensionWidth toSize:200];

    _totalMoneyLabel.textColor = UIColorFromRGB(DefaultColor);
    
    /**
        提交按钮  按钮的点击事件为   "clickCommitButton"
     */
    [_commitButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_commitButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_commitButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_commitButton autoSetDimension:ALDimensionWidth toSize:70];
    _commitButton.layer.cornerRadius = 4;
    _commitButton.layer.masksToBounds = YES;
    [_commitButton addTarget:self action:@selector(clickCommitButton) forControlEvents:UIControlEventTouchUpInside];
    [_commitButton setTitle:NSLocalizedString(@"pushOrderCommitButtonTitle", nil) forState:UIControlStateNormal];
    _commitButton.titleLabel.textColor = [UIColor whiteColor];
    _commitButton.backgroundColor = UIColorFromRGB(DefaultColor);
}

#pragma mark 点击提交按钮
- (void)clickCommitButton{
    NSLog(@"%@",dic);
    _commitButton.enabled = NO;
    [SVProgressHUD showWithStatus:@"提交订单中..." maskType:1];
    [self getInfoFromTableView];
//    [self clientAlipay];
}

#pragma mark 初始化控件
/**
    初始化列表
 */
- (UITableView *)orderTableView{
    if (!_orderTableView) {
        _orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 110) style:UITableViewStyleGrouped];
        _orderTableView.delegate = self;
        _orderTableView.dataSource = self;
        [_orderTableView registerClass:[PushOrderBTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _orderTableView;
}

- (void)dealloc{

}

/**
    提交的view
 */
- (UIView *)commitView{
    if (_commitView == nil) {
        _commitView = [[UIView alloc] initForAutoLayout];
    }
    return _commitView;
}

/**
    初始化“总金额”label
 */
- (UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _totalLabel;
}

/**
    初始化金额数label
 */
- (UILabel *)totalMoneyLabel{
    if (!_totalMoneyLabel) {
        _totalMoneyLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _totalMoneyLabel;
}

/**
    初始化提交按钮
 */
- (UIButton *)commitButton{
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] initForAutoLayout];
    }
    return _commitButton;
}

#pragma mark - tableview的数据源方法和委托
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 1;
//    }
    if (section == 0)
        return 1;
//    else if (section == 1)
//        return 1;
//    else if (section == 3)
//        return 2;
    else if (section == 1)
        return 2;
    else if (section == 2){
        if ([_shopCarArray[8] isEqualToString:@"1"]) {
            return 2;
        }
        return 2;
    }
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PushAddressTableViewCell *cell = [PushAddressTableViewCell cellOfTabelView:tableView cellForRowAtIndex:indexPath];
        cell.dic = GetUserDefault(Address);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if(indexPath.section == 1){
        PushPayTableViewCell *cell = [PushPayTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath];
        if (payMode == indexPath.row) {
            [cell setIsSelectImg:YES andNameTypeString:payArray[indexPath.row] andMarkImg:[UIImage imageNamed:payMarkArray[indexPath.row]]];
        }else{
            [cell setIsSelectImg:NO andNameTypeString:payArray[indexPath.row] andMarkImg:[UIImage imageNamed:payMarkArray[indexPath.row]]];
        }
        return cell;
    }else if (indexPath.section == 2){
        if (indexPath.row != 2) {
            PushOrderBTableViewCell *cell = [PushOrderBTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath forCellReuseIdentifier:@"orderBCell"];
            if (indexPath.row == 3) {
                pointNumIndex = indexPath;
                cell.dic = dic;
            }
            if (indexPath.row == 1) {
                NSMutableDictionary *yunFeiDic = [[NSMutableDictionary alloc] init];
                [yunFeiDic setValue:NSLocalizedString(@"pushOrderCellPlaceholderFreight", nil) forKey:@"typeName"];
                [yunFeiDic setValue:[NSString stringWithFormat:@"%@%@" ,NSLocalizedString(@"Money", nil) , _shopCarArray[1]] forKey:@"typeDetail"];
                cell.dic = yunFeiDic;
            }
            if (indexPath.row == 0) {
                NSMutableDictionary *shopCard = [NSMutableDictionary dictionary];
                [shopCard setValue:NSLocalizedString(@"pushOrderCellPlaceholderViewProductList", nil) forKey:@"typeName"];
                [shopCard setValue:[NSString stringWithFormat:@"%@%@",_shopCarArray[4], NSLocalizedString(@"TheNumberOf", nil)] forKey:@"typeDetail"];
                cell.dic = shopCard;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            return cell;
        }else{
            PointNumTableViewCell *cell = [PointNumTableViewCell cellOfTableView:tableView cellForRowAtIndex:indexPath];
//            NSMutableDictionary *pointDic = GetUserDefault(Person_Info);[pointDic objectForKey:@"integral"]
            cell.pointString = [[PersonInfoModel shareInstance].myJifen stringByAppendingString:@"积分"];
            return cell;
        }
        
    }else{
         PushOrderBTableViewCell *cell = [PushOrderBTableViewCell cellOfTableView:tableView cellForRowAtIndexPath:indexPath forCellReuseIdentifier:cellID];
        [self setCell:cell atIndexPath:indexPath];
        return cell;
    } 
}

- (void)setCell:(PushOrderBTableViewCell *)cell atIndexPath:(NSIndexPath *)index{
    OrderMarkModel *model = [[OrderMarkModel alloc] init];
    model.markTextString = _markString;
    cell.model = model;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return [tableView fd_heightForCellWithIdentifier:cellID configuration:^(PushOrderBTableViewCell *cell) {
            [self setCell:cell atIndexPath:indexPath];
        }];
    }
    else if (indexPath.section == 0)
        return 60;
    else
        return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectIndex = indexPath;
    if (indexPath.section == 0) {
        [self selectAddress];
    }
    if (indexPath.section == 1) {
        payMode = (int)indexPath.row;
        [_orderTableView reloadData];
        if (indexPath.row == 0) {
            payTypeName = @"支付宝";
        }
        if (indexPath.row == 1) {
            payTypeName = @"货到付款";
        }
    }
    if(indexPath.section == 2){
        if (indexPath.row == 0) {
            GoodsWebViewController *viewController = [[GoodsWebViewController alloc] init];
            viewController.webTitle = @"商品清单";
            NSLog(@"%@",_shopCarArray[3]);
            NSString *subUrl = [_shopCarArray[3] substringFromIndex:4];
            viewController.webViewUrl = [@"http:" stringByAppendingString:subUrl];
            viewController.shopName = NSLocalizedString(@"productDetailsNavigationTitle", nil);
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
    if (indexPath.section == 3) {
        InputMarkMessageViewController *viewController = [[InputMarkMessageViewController alloc] init];
        if (self.markString != nil) {
            viewController.markString = self.markString;
        }
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    switch (section) {
        case 0:
            [self labelInView:view andLabelText:NSLocalizedString(@"pushOrderCellHeaderAddressTitle", nil)];
            break;
//        case 3:
////            [self labelInView:view andLabelText:NSLocalizedString(@"pushOrderCellHeaderMyWalletTitle", nil)];
////            break;
//        case 2:
//            [self labelInView:view andLabelText:NSLocalizedString(@"pushOrderCellHeaderTimeTitle", nil)];
//            break;
            
        case 1:
            [self labelInView:view andLabelText:NSLocalizedString(@"pushOrderCellHeaderPaymentTitle", nil)];
            break;
            
        case 2:
            [self labelInView:view andLabelText:NSLocalizedString(@"pushOrderCellHeaderCommodityInformationTitle", nil)];
            break;
            
        case 3:
            [self labelInView:view andLabelText:NSLocalizedString(@"pushOrderCellHeaderNoteInformationTitle", nil)];
            break;
            
        default:
            break;
    }
    return view;
}

- (void)labelInView:(UIView *)view andLabelText:(NSString *)string{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 250, 30)];
    label.text = string;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = UIColorFromRGB(0x444444);
    [view addSubview:label];
}

#pragma mark 提交订单页面数据
- (void)getInfoFromTableView{
    NSDictionary *addressDic = GetUserDefault(Address);
    NSString *address = addressDic[@"address"];
    NSString *addressId = addressDic[@"address_id"];
    NSLog(@"送货地址%@---送货时间%@----支付方式%d=-= =-=%@------%@----andid%@",address,dateString,payMode,_totalMoneyLabel.text,_markString,addressId);
    /*-----支付方式 1为在线支付 0为货到付款-----*/
    NSString *payType = [[NSString alloc] init];
    if (payMode == 1) {
        payType = @"0";
    }else{
        payType = @"1";
    }
    /*-----获取收货人信息-----*/
    NSDictionary *personInfo = GetUserDefault(Address);
    
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"insert_order"];//connect_url(@"insert_order");
    if ([_shopCarArray[2] isEqualToString:@"1"]) {
        [self pushDataToUrl:personInfo andUrl:url andPayType:payType];
    }else{
        NSString *pushUrl = [SwpTools swpToolGetInterfaceURL:@"group_insert"];//connect_url(@"group_insert");
        [self pushDataToUrl:personInfo andUrl:pushUrl andPayType:payType];
    }
}
/**
 *  提交订单
 *
 *  @param personInfo 个人信息
 *  @param url        app_key  不同提交方式app_key不同
 *  @param payType    支付类型
 */
- (void)pushDataToUrl:(NSDictionary *)personInfo andUrl:(NSString *)url andPayType:(NSString *)payType{
#pragma mark - paypal支付
    if ([personInfo objectForKey:@"consignee"] != nil && ![[personInfo objectForKey:@"consignee"] isEqualToString:@""]) {
        if ([dateString isEqualToString:@""] || dateString == nil) {
            dateString = NSLocalizedString(@"pushOrderCellTimePlaceholder", nil);
        }
        if (_markString == nil || [_markString isEqualToString:@""]) {
            _markString = @" ";
        }
        if ([pointNumber isEqualToString:@""]|| pointNumber == nil) {
            pointNumber = @"0";
        }
            //        NSString *pushMOney = [NSString stringWithFormat:@"%0.2f",[totalMoney floatValue]];
            NSDictionary *orderDic = @{
                                       @"app_key" : url,
                                       @"pay_type" : payType,
                                       @"u_id"    : self.personInfoModel.uID,
                                       @"consignee" : [personInfo objectForKey:@"consignee"],
                                       @"mobile"   : [personInfo objectForKey:@"phone_tel"],
                                       @"address"  : [personInfo objectForKey:@"address"],
                                       @"remark"   : _markString,
                                       @"micro_time" : _shopCarArray[7],
                                       @"ship_time" : dateString,
                                       @"goods_list" : _shopCarArray[5],
                                       @"address_id" : [personInfo objectForKey:@"address_id"],
                                       @"isbalbance" : @"0",
                                       @"jifen"      : @"0"
                                       };
            [SwpRequest swpPOST:url parameters:orderDic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
                if ([resultObject[@"code"] integerValue] == 200) {
                    if (![payType isEqualToString:@"0"]) {
//                        alipayOrderDic = resultObject[@"obj"];
//                        NSString *money = [[_totalMoneyLabel.text substringFromIndex:1] substringToIndex:_totalMoneyLabel.text.length - 2];
//                        float moneyNum = [money floatValue];
//                        NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:resultObject[@"obj"]];
//                        [paramDic setValue:[NSString stringWithFormat:@"%d",(int)(moneyNum * 100)] forKey:@"total_money"];
//                        [paramDic setValue:[[resultObject objectForKey:@"obj"] objectForKey:@"order_id"] forKey:@"order_id"];
//                        [paramDic setValue:[WechatOrderInformation orderNumber].orderNumber forKey:@"prepayid"];
//                        NSLog(@"%@",resultObject);
//                        [[UPPaymentControl defaultControl] startPay:resultObject[@"obj"][@"order_id"] fromScheme:@"MallO2O" mode:@"01" viewController:self];
                        [self payPal:resultObject];
                    }else{
                        PushOrderSuccessViewController *viewController = [[PushOrderSuccessViewController alloc] init];
                        viewController.webUrl = resultObject[@"obj"][@"url"];
                        viewController.totalMoney = @"订单提交成功";
                        [self.navigationController pushViewController:viewController animated:YES];
                    }
                }else{
                    _commitButton.enabled = YES;
                    [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
                }

            } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
                _commitButton.enabled = YES;
                [SVProgressHUD showErrorWithStatus:@"网络异常"];
            }];
    }else{
        _commitButton.enabled = YES;
        [SVProgressHUD showErrorWithStatus:@"请选择地址"];
    }
}

#pragma mark - paypal支付
- (void)payPal:(NSDictionary *)paypalDic{
    NSArray *goodsArray = (NSArray *)paypalDic[@"obj"][@"goods_list"];
    NSMutableArray *paypalyArray = [NSMutableArray array];
    for (NSDictionary *goodsDic in goodsArray) {
        PayPalItem *item1 = [PayPalItem itemWithName:goodsDic[@"goods_name"]
                                        withQuantity:[goodsDic[@"num"] integerValue]
                                           withPrice:[NSDecimalNumber decimalNumberWithString:goodsDic[@"price"]]
                                        withCurrency:@"RUB"
                                             withSku:goodsDic[@"goods_name"]];
        [paypalyArray addObject:item1];
    }
    orderId = paypalDic[@"obj"][@"signage"];
    NSArray *items = [NSArray arrayWithArray:paypalyArray];
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    // Optional: include payment details
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"5.99"];
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"2.50"];
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                               withShipping:shipping
                                                                                    withTax:tax];
    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"RUB";
    payment.shortDescription = @"BT'S goods";
    payment.items = items;  // if not including multiple items, then leave payment.items as nil  不是多个项目  会离开支付  items为空
    payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for example, the amount was negative or the shortDescription was empty, this payment wouldn't be processable, and you'd want to handle that here.
        //如果订单是不可处理类型（数量为负数或者为空） 在这里处理逻辑
    }
    
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController{
    [paymentViewController dismissViewControllerAnimated:YES completion:^{
        
        for (MallO2OBaseViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[ShoppingCartViewController class]]) {
                ShoppingCartViewController *ccc = (ShoppingCartViewController *)vc;
                [self.navigationController popToViewController:ccc animated:YES];
            }
        }

        
    }];
}

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment{
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"order_success"];
    NSDictionary *paypalCommpeleteDic = @{
                          @"app_key" : url,
                          @"micro_time" : orderId
                          };
    [SwpRequest swpPOST:url parameters:paypalCommpeleteDic isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if ([resultObject[@"code"] integerValue] == 200) {
            [paymentViewController dismissViewControllerAnimated:YES completion:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
}

/**
 *  ping++提交订单
 *
 *  @param charge ping++所需的参数
 */
- (void) getPingpp:(NSObject *)charge {
    
    [Pingpp createPayment:charge viewController:self appURLScheme:nil withCompletion:^(NSString *result, PingppError *error){
        [SVProgressHUD dismiss];
        NSLog(@"%@", result);
        if ([result isEqualToString:@"success"]) {
            // 支付成功
            NSLog(@"成功");
            PushOrderSuccessViewController *viewController = [[PushOrderSuccessViewController alloc] init];
            viewController.totalMoney = [NSString stringWithFormat:@"成功支付%@",_totalMoneyLabel.text];
            viewController.webUrl = [alipayOrderDic objectForKey:@"url"];
            [self.navigationController pushViewController:viewController animated:YES];
        } else {
            // 支付失败或取消
            NSLog(@"Error: code=%lu msg=%@", (unsigned long)error.code, [error getMsg]);
            if (error.code == 5) {
                [SVProgressHUD showErrorWithStatus:@"取消支付"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
    }];
}

#pragma mark 选择地址
- (void)selectAddress{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Address" bundle:[NSBundle mainBundle]];
    AdressDetailController *vc = [story instantiateViewControllerWithIdentifier:@"adress"];
    vc.isSelectAddress = @"YES";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
