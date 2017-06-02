//
//  InvitationServerViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/14.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "InvitationServerViewController.h"

#import "SwpWeakifyHeader.h"
#import "NationalityCountryViewController.h"
#import "SwpCamera.h"

#import "AddpassengerTableViewCell.h"
#import "InvitationImageTableViewCell.h"
#import "LoginViewController.h"

#import "PassengerModel.h"
#import "InvitationImageModel.h"
#import "ValidityModel.h"
#import "PriceModel.h"

static NSString *const invitationCellID = @"invitationCell";
//static __weak typeof(InvitationServerViewController *) selfVC;

@interface InvitationServerViewController ()<UITableViewDelegate ,UITableViewDataSource ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate ,UIActionSheetDelegate>

/**
 *  邀请函tableview
 */
@property (strong ,nonatomic) UITableView *invitationTableView;
@property (strong ,nonatomic) UIButton   *addBtn;
/**
 *  模型数组
 */
@property (copy ,nonatomic) NSArray *tableViewArray;
/**
 *  图片的模型数组
 */
@property (copy ,nonatomic) NSArray *tableViewImageArray;
/**
 *  保险价格数组
 */
@property (copy ,nonatomic) NSArray *priceArray;
/**
 *  有效期的模型
 */
@property (strong ,nonatomic) ValidityModel *validityModel;
/**
 *  tableview 点击时的索引
 */
@property (copy ,nonatomic) NSIndexPath *selectIndexPath;

@property (strong ,nonatomic) UIDatePicker *datePicker;

@property (copy ,nonatomic) NSIndexPath *clickCellIndexPath;

@end

@implementation InvitationServerViewController{
    /**
     *  点击添加图片的
     */
//    NSIndexPath *clickCellIndexPath;

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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    PassengerModel *model1  = [PassengerModel setPassengerModel:NSLocalizedString(@"invitationServerCellNameTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:NSLocalizedString(@"invitationServerCellNamePlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model1.key = @"name";
    model1.textFieldCanEdit = YES;
    PassengerModel *model2  = [PassengerModel setPassengerModel:NSLocalizedString(@"invitationServerCellTelTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:NSLocalizedString(@"invitationServerCellTelPlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model2.key = @"tel";
    model2.textFieldCanEdit = YES;
    PassengerModel *model3  = [PassengerModel setPassengerModel:NSLocalizedString(@"invitationServerE-mailTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:NSLocalizedString(@"invitationServerE-mailPlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model3.textFieldCanEdit = YES;
    model3.key = @"email";
    PassengerModel *model4  = [PassengerModel setPassengerModel:NSLocalizedString(@"invitationServerCountryCitizenshipTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"NationalityCountryViewController"];
    model4.textFieldCanEdit = NO;
    model4.key = @"nationality";
    PassengerModel *model5  = [PassengerModel setPassengerModel:NSLocalizedString(@"invitationServerSexTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"sex"];
    model5.textFieldCanEdit = NO;
    model5.key = @"sex";
    PassengerModel *model6  = [PassengerModel setPassengerModel:NSLocalizedString(@"invitationServerBirthdayTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"choosetime"];
    model6.textFieldCanEdit = NO;
    model6.key = @"birth";
    PassengerModel *model7  = [PassengerModel setPassengerModel:NSLocalizedString(@"invitationServerDateOfEntryTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"choosetime"];
    model7.textFieldCanEdit = NO;
    model7.key = @"entry_time";
    PassengerModel *model8  = [PassengerModel setPassengerModel:NSLocalizedString(@"invitationServerInvitationTypesTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"type"];
    model8.textFieldCanEdit = NO;
    model8.key = @"invit_type";
    PassengerModel *model9  = [PassengerModel setPassengerModel:NSLocalizedString(@"invitationServerValidityOfTheInvitationTitle", nil) p_id:@"" passengerType:@""detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"validity"];
    model9.textFieldCanEdit = NO;
    model9.key = @"invit_validity";
    self.tableViewArray     = @[model1,model2,model3,model4,model5,model6,model7,model8,model9];
    
    InvitationImageModel *imageModel1 = [[InvitationImageModel alloc] init];
    imageModel1.imageTypeString = NSLocalizedString(@"invitationServerPassportPhotosTitle", nil);
    imageModel1.imageArray = [NSMutableArray array];
    [imageModel1.imageArray addObject:[UIImage imageNamed:@"add_address_sel"]];
    InvitationImageModel *imageModel2 = [[InvitationImageModel alloc] init];
    imageModel2.imageTypeString = NSLocalizedString(@"invitationServerVisaPhotosTitle", nil);
    imageModel2.imageArray = [NSMutableArray array];
    [imageModel2.imageArray addObject:[UIImage imageNamed:@"add_address_sel"]];
    self.tableViewImageArray = @[imageModel1];
    
    PassengerModel *priceModel = [PassengerModel setPassengerModel:NSLocalizedString(@"invitationServerInsurancePriceTitle", nil) p_id:@"" passengerType:@"" detailString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"Money", nil),[PriceModel shareInstance].insurancePrice] placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    priceModel.key = @"insurance_price";
    self.priceArray = @[priceModel];
    self.clickCellIndexPath = [[NSIndexPath alloc] init];
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
    [self setNavBarTitle:NSLocalizedString(@"invitationServerNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setAddButton];
    [self setBackButton];
}
/**
 *  设置导航栏右侧按钮
 */
- (void)setAddButton{
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake(0, 0, 60, 34);
//    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
//    [rightButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
//    [rightButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateHighlighted];
//    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

    self.addBtn              = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame           = CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH, 50);
    self.addBtn.backgroundColor = Color(17, 176, 244, 1);
    [self.addBtn addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
    [self.view addSubview:self.addBtn];

}

- (void)clickAddButton{
    if (![self checkLogin]) {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (PassengerModel *model in self.tableViewArray) {
        if (model.detailString.length == 0){
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"invitationServerCheckInputMessage", nil)];
            return;
        }
        [dic setValue:(model.dataID == nil ? model.detailString : model.dataID) forKey:model.key];
        NSLog(@"%@",model.detailString);
    }
    NSMutableArray *imageArray = [NSMutableArray arrayWithArray:self.tableViewImageArray];
    NSMutableArray *dataArray = [NSMutableArray array];
    NSMutableArray *dataNameArray = [NSMutableArray array];
    int i = 0;
    
    for (InvitationImageModel *model in imageArray) {
        i++;
        NSMutableArray *array = [NSMutableArray arrayWithArray:model.imageArray];
        [array removeLastObject];
        dataArray = [self dataArrayFromModelArray:array];
        for (int i = 0; i < array.count; i ++) {
            [dataNameArray addObject:@"passport_pic"];
        }
    }
    for (PassengerModel *model in self.priceArray) {
        PassengerModel *useModel = model;
        [dic setValue:[useModel.detailString substringFromIndex:1] forKey:useModel.key];
    }
    if (dataArray.count == 0) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"hotboomServeViewControllerAddPickture", nil)];
        dataArray = [[NSMutableArray alloc] init];
        dataNameArray = [[NSMutableArray alloc] init];
        return;
    }
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"invitation_insert"];//@"http://192.168.1.66/baotai/app_action/ac_invitation/invitation_insert";
    [dic setValue:url forKey:@"app_key"];
    [dic setValue:[PersonInfoModel shareInstance].uID forKey:@"u_id"];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"swpNetworkCommitDataing", nil) maskType:SVProgressHUDMaskTypeBlack];
    __weak typeof(self) vc = self;
    NSLog(@"%@",dic);
    [SwpRequest swpPOSTAddFiles:url parameters:dic isEncrypt:[SwpNetworkModel shareInstance].swpNetworkEncrypt fileName:@"passport_pic" fileDatas:dataArray swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        
        [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
        [SVProgressHUD dismiss];
        [vc.navigationController popViewControllerAnimated:YES];
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
    
    NSLog(@"%@",dic);
}

/**
 *  检测是否为邮箱
 *
 *  @param email 输入文字
 */
- (void)checkEmail:(NSString *)email{
    NSString    *mailboxesAre = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate    = [NSPredicate predicateWithFormat:@"self matches %@", mailboxesAre];
    if (![predicate evaluateWithObject:email]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"loginCleckAccount", nil)];
        return;
    }
}

- (void)checkTel:(NSString *)tel{
//    NSString    *mailboxesAre = @"^1[3|4|5|7|8][0-9]\\d{8}$";
//    NSPredicate *predicate    = [NSPredicate predicateWithFormat:@"self matches %@", mailboxesAre];
//    if (![predicate evaluateWithObject:tel]) {
//        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"addAdrsInforCellCkeckTitle", nil)];
//        return;
//    }
}

- (NSMutableArray *)dataArrayFromModelArray:(NSMutableArray *)imageArray{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (UIImage *image in imageArray) {
        UIImage *newImage = [SwpTools swpToolCompressImage:image scaleToSize:CGSizeMake(image.size.width/4, image.size.height/4)];
        NSData *imageData = UIImageJPEGRepresentation(newImage, 0.1);
        [dataArray addObject:imageData];
    }
    return dataArray;
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.invitationTableView];
    
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableViewArray.count + self.tableViewImageArray.count + self.priceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < self.tableViewArray.count) {
        AddpassengerTableViewCell *cell = [AddpassengerTableViewCell addPassengerCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellIdentifier:@"cell"];
        cell.addModel = self.tableViewArray[indexPath.section];
        [self getInputTextFromCell:cell];
        return cell;
    }else if(indexPath.section < (self.tableViewArray.count + self.tableViewImageArray.count)){
        InvitationImageTableViewCell *cell = [InvitationImageTableViewCell invitationImageCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellIdentfier:invitationCellID];
        cell.imageModel = self.tableViewImageArray[indexPath.section - self.tableViewArray.count];
        [self getBlockFromImageCell:cell];
        return cell;
    }
    else{
        AddpassengerTableViewCell *cell = [AddpassengerTableViewCell addPassengerCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellIdentifier:@"cell1"];
        cell.addModel = self.priceArray[0];
        return cell;
    }
}
/**
 *  获取输入的text
 *
 *  @param cell
 */
- (void)getInputTextFromCell:(AddpassengerTableViewCell *)cell{
//    __weak typeof(InvitationServerViewController *) vc = self;
//    @swpWeakify(self);
    __weak typeof(self) selfVC = self;
    
    [cell getAddpassengerTableViewCellBlock:^(NSString *inputText, NSInteger index, NSInteger indexRow) {
       
        PassengerModel *model = selfVC.tableViewArray[index];
        model.detailString = inputText;
        
    }];
    
//    [cell getAddpassengerTableViewCellBlock:^(NSString *inputText, NSInteger index) {
////        @swpStrongify(self);
//    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section >= self.tableViewArray.count && indexPath.section < (self.tableViewArray.count + self.tableViewImageArray.count)) {
        return 85;
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndexPath = [[NSIndexPath alloc] init];
    self.selectIndexPath = indexPath;
//    __weak typeof(self) selfVC = self;
    if (indexPath.section < self.tableViewArray.count) {
        PassengerModel *model = self.tableViewArray[indexPath.section];
        if ([model.viewControllerName isEqualToString:@"sex"]) {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"invitationServerSexTitle", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"invitationServerSexManTitle", nil), NSLocalizedString(@"invitationServerSexWomanTitle", nil), nil];
            actionSheet.tag = 2;
            [actionSheet showInView:self.view];
            [self.view endEditing:YES];
            
            return;
        }
        if ([model.viewControllerName isEqualToString:@"type"]) {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"invitationServerInvitationTypeTitle", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"invitationServerGroupTitle", nil) , NSLocalizedString(@"invitationServerOnceAPersonTitle", nil), NSLocalizedString(@"invitationServerPersonalManyTimesTitle", nil), nil];
            actionSheet.tag = 3;
            [actionSheet showInView:self.view];
            [self.view endEditing:YES];
            return;
        }
        if ([model.viewControllerName isEqualToString:@"validity"]) {
            if (self.validityModel == nil) {
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"invitationServerInvitationTypeTitle", nil)];
                return;
            }
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:self.validityModel.validityType delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:self.validityModel.validityTimeOne,self.validityModel.validityTimeTwo,self.validityModel.validityTimeThree, nil];
            actionSheet.tag = 4;
            [actionSheet showInView:self.view];
            [self.view endEditing:YES];
            return;
        }
        if ([model.viewControllerName isEqualToString:@"choosetime"]) {
            [self chooseTimeIndexPath:indexPath];
        }
        if (model.viewControllerName.length > 0) {
            if ([NSClassFromString(model.viewControllerName) isSubclassOfClass:[NationalityCountryViewController class]]) {
                NationalityCountryViewController *vc = [[NSClassFromString(model.viewControllerName) alloc] init];
//                @swpWeakify(self);
                __weak typeof(self) selfVC = self;
                [vc getCountryNameAndCountryID:^(NSString *countryName, NSString *countryID) {
//                    @swpStrongify(self);
                    NSLog(@"%@%@",countryID,countryName);
                    model.detailString = countryName;
                    model.dataID = countryID;
                    [selfVC.invitationTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                }];
                [self.navigationController pushViewController:vc animated:YES];

            }
        }
    }
}

#pragma mark - 包涵添加图片点击的bloc和删除按钮点击的block
/**
 *  照片的block
 *  包涵添加图片点击的bloc和删除按钮点击的block
 *
 *  @param cell 照片所在的cell
 */
- (void)getBlockFromImageCell:(InvitationImageTableViewCell *)cell{
//    __weak typeof(InvitationServerViewController *)vc = self;
//    @swpWeakify(self);
    __weak typeof(self) vc = self;
    [cell clickAddButtonBlock:^(BOOL canClick ,NSIndexPath *cellIndexPath) {
//        @swpStrongify(self);
        if (!canClick) {
            NSLog(@"click add button");
            NSLog(@"%d",(int)cellIndexPath.section);
            vc.clickCellIndexPath = cellIndexPath;
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"CameraTitle", nil) delegate:vc cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Photograph", nil), NSLocalizedString(@"Album", nil), nil];
            actionSheet.tag = 1;
            [actionSheet showInView:vc.view];
        }else{
            [SVProgressHUD showErrorWithStatus:@""];
        }
    }];
    [cell clickDeleteButton:^(NSIndexPath *indexPath) {
        NSLog(@"click delete button");
    
#warning --- 删除按钮点击的 block
        
        
    }];
}
/**
 *  actionsheet 的代理方法
 *
 *  @param actionSheet actionsheet
 *  @param buttonIndex 点击按钮索引
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self addPhotoFromActionSheet:actionSheet andButtonIndex:buttonIndex];
    [self chooseSexFromActionSheet:actionSheet andButtonIndex:buttonIndex];
    [self invitationTypeFromActionSheet:actionSheet andButtonIndex:buttonIndex];
    if (actionSheet.tag == 4) {
        buttonIndex == 0 ? [self setValidityTypeCellText:self.validityModel.validityTimeOne] : (buttonIndex == 1? [self setValidityTypeCellText:self.validityModel.validityTimeTwo] : (buttonIndex == 2 ? [self setValidityTypeCellText:self.validityModel.validityTimeThree] : @""));
    }
    if (actionSheet.tag == 5) {
        if (buttonIndex == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
            [formatter setTimeZone:timeZone];
            NSString *nowtimeStr = [formatter stringFromDate:_datePicker.date];
            PassengerModel *model = self.tableViewArray[self.selectIndexPath.section];
            model.detailString = nowtimeStr;
            model.dataID = [NSString stringWithFormat:@"%ld",(long)[_datePicker.date timeIntervalSince1970]];
            [self.invitationTableView reloadRowsAtIndexPaths:@[self.selectIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
    if (actionSheet.tag == 3) {
        PassengerModel *model = self.tableViewArray[self.selectIndexPath.section];
        model.dataID = [NSString stringWithFormat:@"%d",(int)buttonIndex + 1];
    }
}
/**
 *  打开照片方式的action
 *
 *  @param actionSheet
 *  @param buttonIndex
 */
- (void)addPhotoFromActionSheet:(UIActionSheet *)actionSheet andButtonIndex:(NSInteger )buttonIndex{
    if (actionSheet.tag == 1) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        if (buttonIndex == 0) {
            NSLog(@"拍照");
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }else{
                NSLog(@"模拟器无法打开相机");
                return;
            }
            [self presentViewController:picker animated:YES completion:^{
                
            }];
        }
        if (buttonIndex == 1) {
            NSLog(@"相册");
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:^{
            
            }];
        }
    }
}
/**
 *  选择性别
 *
 *  @param actionSheet
 *  @param buttonIndex
 */
- (void)chooseSexFromActionSheet:(UIActionSheet *)actionSheet andButtonIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 2) {
        PassengerModel *model = self.tableViewArray[self.selectIndexPath.section] ;
        if (buttonIndex == 0) {
            model.detailString = NSLocalizedString(@"invitationServerSexManTitle",  nil);
            model.dataID = @"1";
            [self.invitationTableView reloadRowsAtIndexPaths:@[self.selectIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        if (buttonIndex == 1) {
            model.detailString = NSLocalizedString(@"invitationServerSexWomanTitle", nil);
            model.dataID = @"0";
            [self.invitationTableView reloadRowsAtIndexPaths:@[self.selectIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}
/**
 *  选择邀请函类型
 *
 *  @param actionSheet
 *  @param buttonIndex
 */
- (void)invitationTypeFromActionSheet:(UIActionSheet *)actionSheet andButtonIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 3) {
        PassengerModel *model = self.tableViewArray[self.selectIndexPath.section + 1] ;
        model.detailString = @"";
        if (buttonIndex == 0) {
//            model.dataID = @"1";
            [self setValidityTypeCellText:NSLocalizedString(@"invitationServerGroupTitle", nil)];
            self.validityModel = [ValidityModel setValidityType:NSLocalizedString(@"invitationServerValidityPeriodGroupTitle", nil) validityTimeOne:NSLocalizedString(@"invitationServerValidityPeriod10Days", nil) validityTimeTwo:NSLocalizedString(@"invitationServerValidityPeriod15Days", nil) validityTimeThree:NSLocalizedString(@"invitationServerValidityPeriod30Days", nil)];
        }
        if (buttonIndex == 1) {
//            model.dataID = @"2";
            [self setValidityTypeCellText:NSLocalizedString(@"invitationServerOnceAPersonTitle", nil)];
            self.validityModel = [ValidityModel setValidityType:NSLocalizedString(@"invitationServerValidityPeriodOnceAPersonTitle", nil) validityTimeOne:NSLocalizedString(@"invitationServerValidityPeriod10Days", nil) validityTimeTwo:NSLocalizedString(@"invitationServerValidityPeriod15Days", nil) validityTimeThree:NSLocalizedString(@"invitationServerValidityPeriod30Days", nil)];
        }
        if (buttonIndex == 2) {
//            model.dataID = @"3";
            [self setValidityTypeCellText:NSLocalizedString(@"invitationServerPersonalManyTimesTitle", nil)];
            self.validityModel = [ValidityModel setValidityType:NSLocalizedString(@"invitationServerValidityPeriodPersonalManyTimesTitle", nil) validityTimeOne:NSLocalizedString(@"invitationServerValidityPeriodHalfAYear", nil) validityTimeTwo:NSLocalizedString(@"invitationServerValidityPeriodAYear", nil) validityTimeThree:nil];
        }
    }
}

- (void)setValidityTypeCellText:(NSString *)text{
    PassengerModel *model = self.tableViewArray[self.selectIndexPath.section];
    model.detailString = text;
//    [self.invitationTableView reloadRowsAtIndexPaths:@[self.selectIndexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    [self.invitationTableView reloadData];
}

- (void)chooseTimeIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) vc = self;
    NSString *message = @"\n\n\n\n\n\n\n\n\n\n\n\n\n";
    if (IOS9) {
        message = @"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
    }
    [GzyCommenMetthod setActionSheetTitle:NSLocalizedString(@"OK", nil) andMeesage:message addView:self.datePicker inViewController:self buttonArray:nil andActionSheetTag:5 delegate:self andComplete:^(UIAlertAction *action) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
        [formatter setTimeZone:timeZone];
        NSString *nowtimeStr = [formatter stringFromDate:vc.datePicker.date];
        PassengerModel *model = vc.tableViewArray[indexPath.section];
        model.detailString = nowtimeStr;
        model.dataID = [NSString stringWithFormat:@"%ld",(long)[vc.datePicker.date timeIntervalSince1970]];
        [vc.invitationTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [vc.datePicker removeFromSuperview];
        vc.datePicker = nil;
    } andCancleAction:^(UIAlertAction *action) {
        
    } andOtherAction:^(UIAlertAction *action) {
        
    } okButtonIsNil:NO];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    InvitationImageModel *model = self.tableViewImageArray[self.clickCellIndexPath.section - self.tableViewArray.count];
    [model.imageArray removeLastObject];
    [model.imageArray addObject:image];
    [model.imageArray addObject:[UIImage imageNamed:@"add_address_sel"]];
    [self.invitationTableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 懒加载
- (UITableView *)invitationTableView{
    if (!_invitationTableView) {
        _invitationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64-50) style:UITableViewStyleGrouped];
        [_invitationTableView registerClass:[AddpassengerTableViewCell class] forCellReuseIdentifier:@"cell"];
        [_invitationTableView registerClass:[InvitationImageTableViewCell class] forCellReuseIdentifier:invitationCellID];
        [_invitationTableView registerClass:[AddpassengerTableViewCell class] forCellReuseIdentifier:@"cell1"];
        _invitationTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        _invitationTableView.delegate = self;
        _invitationTableView.dataSource = self;
    }
    return _invitationTableView;
}

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH - 20, 300)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datePicker;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)dealloc{
    NSLog(@"_________________________释放控制器_________________________");
}



@end
