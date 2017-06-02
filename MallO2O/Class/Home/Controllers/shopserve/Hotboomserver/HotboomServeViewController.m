//
//  HotboomServeViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/15.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "HotboomServeViewController.h"

#import "SwpCamera.h"

#import "HotboomPriceRangeViewController.h"
#import "HotboomDetailNeedViewController.h"
#import "LoginViewController.h"

#import "AddpassengerTableViewCell.h"
#import "HotboomTableViewCell.h"

#import "PassengerModel.h"
#import "HotboomModel.h"

static NSString *const cellID = @"singplecell";
static NSString *const imageCellId = @"imagecell";

@interface HotboomServeViewController ()<UITableViewDelegate ,UITableViewDataSource ,UINavigationControllerDelegate ,UIImagePickerControllerDelegate>

@property (strong ,nonatomic) UITableView *hotboomTableView;

@property (strong ,nonatomic) NSArray *tableViewArray;

@property (strong ,nonatomic) NSArray *imageArray;
@property (nonatomic, strong) SwpCamera *camera;

@property (copy ,nonatomic) NSString *lowPrice;

@property (copy ,nonatomic) NSString *highPrice;

@end

@implementation HotboomServeViewController

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
    PassengerModel *model1 = [PassengerModel setPassengerModel:NSLocalizedString(@"hotboomServeCellCommodityNameTitle", nil) p_id:@"" passengerType:@""   detailString:@"" placeHolder:NSLocalizedString(@"hotboomServeCellCommodityNamePlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model1.textFieldCanEdit = YES;
    model1.key = @"goods_name";
    PassengerModel *model2 = [PassengerModel setPassengerModel:NSLocalizedString(@"hotboomServeCellPriceRangeTitle", nil) p_id:@"" passengerType:@""  detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"HotboomPriceRangeViewController"];
    PassengerModel *model3 = [PassengerModel setPassengerModel:NSLocalizedString(@"hotboomServeCellDetailedRequirementsTitle", nil) p_id:@"" passengerType:@""  detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"HotboomDetailNeedViewController"];
    model3.key = @"goods_desc";
    PassengerModel *model4 = [PassengerModel setPassengerModel:NSLocalizedString(@"hotboomServeCellFullNameTitle", nil) p_id:@"" passengerType:@""  detailString:@"" placeHolder:NSLocalizedString(@"hotboomServeCellFullNamePlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model4.textFieldCanEdit = YES;
    model4.key = @"name";
    PassengerModel *model5 = [PassengerModel setPassengerModel:NSLocalizedString(@"hotboomServeCellTelephoneTitle", nil) p_id:@"" passengerType:@""  detailString:@"" placeHolder:NSLocalizedString(@"hotboomServeCellTelephonePlaceholder",  nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model5.textFieldCanEdit = YES;
    model5.key = @"tel";
    PassengerModel *model6 = [PassengerModel setPassengerModel:NSLocalizedString(@"hotboomServeCellE-mailTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:NSLocalizedString(@"hotboomServeCellE-mailPlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model6.textFieldCanEdit = YES;
    model6.key = @"email";
    PassengerModel *model7 = [PassengerModel setPassengerModel:NSLocalizedString(@"hotboomServeCellPassportNumberTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:NSLocalizedString(@"hotboomServeCellPassportNumberPlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model7.textFieldCanEdit = YES;
    model7.key = @"passport";
    self.tableViewArray = @[model1,model2,model3,model4,model5,model6,model7];
    
    HotboomModel *model = [[HotboomModel alloc] init];
    model.typeName = NSLocalizedString(@"hotboomServeCellReferencePictureTitle", nil);
    model.hotboomImage = [UIImage imageNamed:@"example_image"];
    self.imageArray = @[model];
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

- (void)clickRightButton{
    if (![self checkLogin]) {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }
    NSMutableArray *dataArray = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"indent_buying_insert"];//@"http://192.168.1.66/baotai/app_action/ac_indent_buying/indent_buying_insert";
    for (PassengerModel *model in self.tableViewArray) {
        if (model.key != nil) {
            if (model.detailString.length == 0) {
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"invitationServerCheckInputMessage", nil)];
                return;
            }
            [dic setValue:(model.dataID == nil ? model.detailString : model.dataID) forKey:model.key];
        }
    }
    
    [dic setValue:self.lowPrice forKey:@"price_low"];
    [dic setValue:self.highPrice forKey:@"price_high"];
    [dic setValue:[PersonInfoModel shareInstance].uID forKey:@"u_id"];
    [dic setValue:url forKey:@"app_key"];
    for (HotboomModel *model in self.imageArray) {
        UIImage *image = [SwpTools imageWithImageSimple:model.hotboomImage scaledToSize:CGSizeMake(model.hotboomImage.size.width/4, model.hotboomImage.size.height/4)];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        [dataArray addObject:imageData];
    }
    if (dataArray.count == 0) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"hotboomServeViewControllerAddPickture", nil)];
        return;
    }
    __weak typeof(self) vc = self;
    [SwpRequest swpPOSTAddFile:url parameters:dic isEncrypt:[SwpNetworkModel shareInstance].swpNetworkEncrypt fileName:@"yz_img" fileData:dataArray[0] swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@",resultObject);
        [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
        [vc.navigationController popViewControllerAnimated:YES];
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"shopTravelServePurchasingServiceTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.hotboomTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableViewArray.count + self.imageArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.imageArray.count > indexPath.section) {
        HotboomTableViewCell *cell = [HotboomTableViewCell hotboomCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellID:imageCellId];
        cell.model = self.imageArray[indexPath.section];
        return cell;
    }
    __weak typeof(self) selfVC = self;
    AddpassengerTableViewCell *cell = [AddpassengerTableViewCell addPassengerCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellIdentifier:cellID];
    cell.addModel = self.tableViewArray[indexPath.section - self.imageArray.count];
    
    [cell getAddpassengerTableViewCellBlock:^(NSString *inputText, NSInteger index, NSInteger indexRow) {
       
        
        PassengerModel *model = selfVC.tableViewArray[index - selfVC.imageArray.count];
        model.detailString = inputText;
        
        
    }];
    
//    [cell getAddpassengerTableViewCellBlock:^(NSString *inputText, NSInteger index) {
//    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.imageArray.count > indexPath.section) {
        return 57 * Balance_Heith;
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) selfVC = self;
    if (self.imageArray.count > indexPath.section) {
        [self.camera swpCameraDisplay:self title:NSLocalizedString(@"CameraTitle", nil) cameraTitle:NSLocalizedString(@"Photograph", nil) photoAlbumTitle:NSLocalizedString(@"Album", nil) cancelTitle:NSLocalizedString(@"Cancel", nil)];
        [self.camera swpCameraChooseImageSuccess:^(SwpCamera * _Nonnull swpCamera, UIImagePickerController * _Nonnull picker, NSDictionary * _Nonnull info, UIImage * _Nonnull chooseImage) {
            NSLog(@"%@",chooseImage);
            UIImage *newSizeImage = [SwpTools swpToolCompressImage:chooseImage scaleToSize:CGSizeMake(chooseImage.size.width / 4, chooseImage.size.height/4)];
            NSLog(@"%@",newSizeImage);
            HotboomModel *model = selfVC.imageArray[indexPath.section];
            model.hotboomImage = newSizeImage;
            [selfVC.hotboomTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }else{
        PassengerModel *model = self.tableViewArray[indexPath.section - self.imageArray.count];
        if (NSClassFromString(model.viewControllerName) != nil) {
            if ([NSClassFromString(model.viewControllerName) isSubclassOfClass:[HotboomPriceRangeViewController class]]) {
                HotboomPriceRangeViewController *viewController = [[NSClassFromString(model.viewControllerName) alloc] init];
                [viewController getPriceRange:^(NSString *lowPrice, NSString *highPrice) {
                    PassengerModel *model = selfVC.tableViewArray[indexPath.section - selfVC.imageArray.count];
                    model.detailString = [lowPrice stringByAppendingFormat:@" - %@",highPrice];
                    selfVC.lowPrice = lowPrice;
                    selfVC.highPrice = highPrice;
                    [selfVC.hotboomTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                }];
                [self.navigationController pushViewController:viewController animated:YES];
            }
            if ([NSClassFromString(model.viewControllerName) isSubclassOfClass:[HotboomDetailNeedViewController class]]) {
                HotboomDetailNeedViewController *viewcontroller = [[NSClassFromString(model.viewControllerName) alloc] init];
                [viewcontroller getDetailInfo:^(NSString *inputText) {
                    PassengerModel *model = selfVC.tableViewArray[indexPath.section - selfVC.imageArray.count];
                    model.detailString = inputText;
                    [selfVC.hotboomTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                }];
                [self.navigationController pushViewController:viewcontroller animated:YES];
            }
        }
    }
}

/**
 *  初始化tableview
 *
 *  @return
 */
- (UITableView *)hotboomTableView{
    if (!_hotboomTableView) {
        _hotboomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
        [_hotboomTableView registerClass:[AddpassengerTableViewCell class] forCellReuseIdentifier:cellID];
        [_hotboomTableView registerClass:[HotboomTableViewCell class] forCellReuseIdentifier:imageCellId];
        _hotboomTableView.delegate = self;
        _hotboomTableView.dataSource = self;
    }
    return _hotboomTableView;
}

- (SwpCamera *)camera {
    return !_camera ? _camera = ({
        SwpCamera *camera = [SwpCamera new];
        camera;
    }) : _camera;
}

- (void)dealloc{
    NSLog(@":D :D :D");
}

@end
