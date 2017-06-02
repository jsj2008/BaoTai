//
//  CarServerViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/16.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "CarServerViewController.h"

#import "FSCalendar.h"
#import "SwpCamera.h"

#import "CanlendarViewController.h"
#import "NationalityCountryViewController.h"
#import "LoginViewController.h"

#import "HotboomTableViewCell.h"
#import "AddpassengerTableViewCell.h"

#import "PassengerModel.h"
#import "PriceModel.h"
#import "HotboomModel.h"

@interface CarServerViewController ()<UITableViewDataSource ,UITableViewDelegate ,UIActionSheetDelegate>

@property (strong ,nonatomic) UITableView *carServerTableView;

@property (strong ,nonatomic) UIButton *addBtn;

@property (copy ,nonatomic  ) NSArray     *tableViewArray;

@property (copy ,nonatomic  ) NSArray     *imageArray;

@property (copy ,nonatomic  ) NSArray     *tableViewSecondArray;

@property (copy ,nonatomic  ) NSString    *dateString;

@property (strong ,nonatomic) SwpCamera   *camera;

@property (strong ,nonatomic)   UIDatePicker *datePicker;

@property (copy ,nonatomic  ) NSString    *arriveType;

@property (strong ,nonatomic) PassengerModel *selectModel;

@property (strong ,nonatomic) NSIndexPath *selectIndexPath;

@property (assign, nonatomic) UIDatePickerMode selectPickerMode;

@end

@implementation CarServerViewController

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
    self.selectIndexPath = [[NSIndexPath alloc] init];
    PassengerModel *model1    = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellDateOfEntryTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"choosedate"];
    model1.key = @"entry_time";
    
    PassengerModel *model2    = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellNationalityTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"NationalityCountryViewController"];
    model2.key = @"nationality";
    
    PassengerModel *model3    = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellNameTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:NSLocalizedString(@"carServerCellNamePlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model3.textFieldCanEdit   = YES;
    model3.key = @"name";
    
    PassengerModel *model4    = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellTelephoneTitle", nil) p_id:@"" passengerType:@""  detailString:@"" placeHolder:NSLocalizedString(@"carServerCellTelephonePlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model4.textFieldCanEdit   = YES;
    model4.key = @"tel";
    
    PassengerModel *model5    = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellLicensePlateNumberTitle", nil) p_id:@"" passengerType:@""  detailString:@"" placeHolder:NSLocalizedString(@"carServerCellLicensePlateNumberPlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model5.textFieldCanEdit   = YES;
    model5.key = @"plate_num";
    
    PassengerModel *model6    = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellFrameNumberTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:NSLocalizedString(@"carServerCellFrameNumberPlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model6.textFieldCanEdit   = YES;
    model6.key = @"frame_num";
    
    PassengerModel *model7    = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellEngineNumberTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:NSLocalizedString(@"carServerCellEngineNumberPlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    model7.textFieldCanEdit   = YES;
    model7.key = @"engine_num";
    
    PassengerModel *model8    = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellModelsTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"cartype"];
    model8.key = @"model";
    self.tableViewArray       = @[model1,model2,model3,model4,model5,model6,model7,model8];

    HotboomModel *imageModel1 = [[HotboomModel alloc] init];
    imageModel1.typeName      = NSLocalizedString(@"carServerCellDrivingLicensePhotoTitle", nil);
    imageModel1.hotboomImage  = [UIImage imageNamed:@"example_image"];

    HotboomModel *imageModel2 = [[HotboomModel alloc] init];
    imageModel2.typeName      = NSLocalizedString(@"carServerCellPassportPhotoDriverTitle", nil);
    imageModel2.hotboomImage  = [UIImage imageNamed:@"example_image"];
    self.imageArray           = @[imageModel1 ,imageModel2];

    PassengerModel *secondModel1 = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellDestinationTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:NSLocalizedString(@"carServerCellDestinationPlaceholder", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    secondModel1.textFieldCanEdit = YES;
    secondModel1.key = @"destination";
    PassengerModel *secondModel2 = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellEntryModeTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"arrivedtype"];
    secondModel2.key = @"entry_method";
    PassengerModel *secondModel3 = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellShiftTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:NSLocalizedString(@"carServerTicketAirImbalance", nil) cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@"numberofruns"];
    secondModel3.key = @"classes";
    secondModel3.textFieldCanEdit = YES;
    PassengerModel *secondModel4 = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellArrivalTimeTitle", nil) p_id:@"" passengerType:@"" detailString:@"" placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryDisclosureIndicator pushViewControllerName:@"choosetime"];
    secondModel4.key = @"arrival_time";
    PassengerModel *secondModel5 = [PassengerModel setPassengerModel:NSLocalizedString(@"carServerCellPriceTitle", nil) p_id:@"" passengerType:@"" detailString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"Money", nil),[PriceModel shareInstance].serverPrice] placeHolder:@"" cellAccessoryType:UITableViewCellAccessoryNone pushViewControllerName:@""];
    secondModel5.key = @"insurance_price";
    self.tableViewSecondArray = @[secondModel1,secondModel2,secondModel3,secondModel4,secondModel5];
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
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
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
    __weak typeof(self)selfVC = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *imageArray = [NSMutableArray array];
    NSString *url = [SwpTools swpToolGetInterfaceURL:@"pickup_service_insert"];//@"http://192.168.1.66/baotai/app_action/ac_pickup_service/pickup_service_insert";
    for (PassengerModel *model in self.tableViewArray) {
        if (model.detailString.length == 0 || model.detailString == nil) {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"carServerCheckUserInputMessageTitle", nil)];
            return;
        }
        [dic setValue:(model.dataID == nil ? model.detailString : model.dataID) forKey:model.key];
    }
    for (PassengerModel *model in self.tableViewSecondArray) {
        if ([model.viewControllerName isEqualToString:@"numberofruns"]) {
            if ([self.arriveType isEqualToString:NSLocalizedString(@"carServerHighway", nil)]) {
                model.detailString = @" ";
            }
        }
        if (model.detailString.length == 0 || model.detailString == nil) {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"carServerCheckUserInputMessageTitle", nil)];
            return;
        }
        [dic setValue:(model.dataID == nil ? model.detailString : model.dataID) forKey:model.key];
        if ([model.key isEqualToString:@"insurance_price"]) {
            [dic setValue:[model.detailString substringFromIndex:1] forKey:model.key];
        }
    }
    for (HotboomModel *model in self.imageArray) {
        UIImage *newImage = [SwpTools imageWithImageSimple:model.hotboomImage scaledToSize:CGSizeMake(model.hotboomImage.size.width/4, model.hotboomImage.size.height/4)];
        NSData *imageData = UIImageJPEGRepresentation(newImage, 0.1);
        [imageArray addObject:imageData];
    }
    [dic setValue:url forKey:@"app_key"];
    [dic setValue:[PersonInfoModel shareInstance].uID forKey:@"u_id"];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"swpNetworkCommitDataing", nil) maskType:SVProgressHUDMaskTypeBlack];
    [SwpRequest swpPOSTAddWithFiles:url parameters:dic isEncrypt:[SwpNetworkModel shareInstance].swpNetworkEncrypt fileNames:@[@"driving_license_pic",@"driver_passport_pic"] fileDatas:imageArray swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@",resultObject);
        if ([resultObject[@"code"] integerValue] == 200){
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:resultObject[@"message"]];
            [selfVC.navigationController popViewControllerAnimated:YES];
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    
    
    [self setNavBarTitle:NSLocalizedString(@"carServerNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
//    [self setRightButton:@selector(clickButton:) andButtonNormalTitle:@"确定"];
    [self setBackButton];
}

- (void)clickButton:(UIButton *)button{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (PassengerModel *model in self.tableViewArray) {
        if ([model.detailString isEqualToString:@""]){
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"carServerCheckUserInputMessageTitle", nil)];
            return;
        }
        [dic setValue:model.dataID == nil ? model.detailString : model.dataID forKey:model.typeString];
    }
    for (PassengerModel *model in self.tableViewSecondArray) {
        if ([model.detailString isEqualToString:@""]){
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"carServerCheckUserInputMessageTitle", nil)];
            return;
        }
        [dic setValue:model.dataID == nil ? model.detailString : model.dataID forKey:model.typeString];
    }
    NSLog(@"%@",dic);
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.carServerTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableViewArray.count + self.tableViewSecondArray.count + self.imageArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) vc = self;
    if (indexPath.section < self.tableViewArray.count) {
        PassengerModel *model           = self.tableViewArray[indexPath.section];
        AddpassengerTableViewCell *cell = [AddpassengerTableViewCell addPassengerCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellIdentifier:@"cell1"];
        cell.addModel                   = model;
        [cell getAddpassengerTableViewCellBlock:^(NSString *inputText, NSInteger index, NSInteger indexRow) {
           
            PassengerModel *model = vc.tableViewArray[index];
            model.detailString    = inputText;
        }];
        
//        [cell getAddpassengerTableViewCellBlock:^(NSString *inputText, NSInteger index) {
//        }];
        return cell;
    }else if (indexPath.section < (self.tableViewArray.count + self.imageArray.count)) {
        HotboomModel *model        = self.imageArray[indexPath.section - self.tableViewArray.count];
        HotboomTableViewCell *cell = [HotboomTableViewCell hotboomCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellID:@"imageCell"];
        cell.model                 = model;
        return cell;
    }else{
        PassengerModel *model           = self.tableViewSecondArray[indexPath.section - self.tableViewArray.count - self.imageArray.count];
        AddpassengerTableViewCell *cell = [AddpassengerTableViewCell addPassengerCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellIdentifier:@"cell2"];
        cell.addModel                   = model;
        
        [cell getAddpassengerTableViewCellBlock:^(NSString *inputText, NSInteger index, NSInteger indexRow) {
           
            PassengerModel *model = vc.tableViewSecondArray[index - vc.tableViewArray.count - vc.imageArray.count];
            model.detailString    = inputText;
            
        }];
        
//        [cell getAddpassengerTableViewCellBlock:^(NSString *inputText, NSInteger index) {
//        }];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < (self.tableViewArray.count + self.imageArray.count) && indexPath.section >= self.tableViewArray.count){
        return 60;
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) selfVc = self;
    if (self.tableViewArray.count > indexPath.section) {
        PassengerModel *model = self.tableViewArray[indexPath.section];
        if ([NSClassFromString(model.viewControllerName) isSubclassOfClass:[NationalityCountryViewController class]]) {
            NationalityCountryViewController *vc = [[NSClassFromString(model.viewControllerName) alloc] init];
            [vc getCountryNameAndCountryID:^(NSString *countryName, NSString *countryID) {
                model.detailString = countryName;
                model.dataID = countryID;
                [selfVc.carServerTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([model.viewControllerName isEqualToString:@"choosedate"]) {
            [self chooseTimeIndexPath:indexPath andDateType:UIDatePickerModeDate andModel:model];
        }
        if ([model.viewControllerName isEqualToString:@"cartype"]) {
            [self chooseCarType:indexPath];
        }
    }
    if (indexPath.section >= self.tableViewArray.count  && indexPath.section < self.tableViewArray.count +self.imageArray.count) {
        NSLog(@"点击图片");
        [self.camera swpCameraDisplay:self title:NSLocalizedString(@"CameraTitle", nil) cameraTitle:NSLocalizedString(@"Photograph", nil) photoAlbumTitle:NSLocalizedString(@"Album", nil) cancelTitle:NSLocalizedString(@"Cancel", nil)];
        
        [self.camera swpCameraChooseImageSuccess:^(SwpCamera * _Nonnull swpCamera, UIImagePickerController * _Nonnull picker, NSDictionary * _Nonnull info, UIImage * _Nonnull chooseImage) {
            NSLog(@"%@",chooseImage);
            UIImage *newSizeImage = [SwpTools swpToolCompressImage:chooseImage scaleToSize:CGSizeMake(chooseImage.size.width / 4, chooseImage.size.height/4)];
            NSLog(@"%@",newSizeImage);
            HotboomModel *model = selfVc.imageArray[indexPath.section - selfVc.tableViewArray.count];
            model.hotboomImage = newSizeImage;
            [selfVc.carServerTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    if (indexPath.section >= (self.tableViewArray.count + self.imageArray.count)) {
        PassengerModel *model = self.tableViewSecondArray[indexPath.section - self.tableViewArray.count - self.imageArray.count];
        if ([model.viewControllerName isEqualToString:@"choosetime"]) {
            [self chooseTimeIndexPath:indexPath andDateType:UIDatePickerModeDateAndTime andModel:model];
        }
        if ([model.viewControllerName isEqualToString:@"arrivedtype"]) {
            [self setArrivedType:model atIndexPath:indexPath];
        }
    }
}

- (void)setArrivedType:(PassengerModel *)model atIndexPath:(NSIndexPath *)indexPath{
    self.selectModel = model;
    self.selectIndexPath = indexPath;
    __weak typeof(self) vc = self;
    [GzyCommenMetthod setActionSheetTitle:NSLocalizedString(@"carServerChooseEnterACountryType", nil) andMeesage:nil addView:nil inViewController:self buttonArray:@[NSLocalizedString(@"carServerHighway", nil),NSLocalizedString(@"carServerPlane", nil),NSLocalizedString(@"carServerTrain", nil)] andActionSheetTag:2 delegate:self andComplete:^(UIAlertAction *action) {

    } andCancleAction:^(UIAlertAction *action) {
        
    } andOtherAction:^(UIAlertAction *action) {
        vc.selectModel.detailString = action.title;
        vc.arriveType = action.title;
        [vc.carServerTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    } okButtonIsNil:YES];
}

- (void)chooseTimeIndexPath:(NSIndexPath *)indexPath andDateType:(UIDatePickerMode)datePickerMode andModel:(PassengerModel *)mode{
    self.datePicker.datePickerMode = datePickerMode;
    self.datePicker.date = [NSDate date];
    self.selectModel = mode;
    self.selectIndexPath = indexPath;
    self.selectPickerMode = datePickerMode;
    __weak typeof(self) vc = self;
    NSString *message = @"\n\n\n\n\n\n\n\n\n\n\n";
    if (IOS9) {
        message = @"\n\n\n\n\n\n\n\n\n\n\n\n\n";
    }
    [GzyCommenMetthod setActionSheetTitle:NSLocalizedString(@"planeBookPleaseChooseTime", nil) andMeesage:message addView:_datePicker inViewController:self buttonArray:nil andActionSheetTag:3 delegate:self andComplete:^(UIAlertAction *action) {
        NSLog(@"%@",vc.datePicker.date);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        if (datePickerMode == UIDatePickerModeDateAndTime) {
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        }
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
        [formatter setTimeZone:timeZone];
        NSString *nowtimeStr = [formatter stringFromDate:vc.datePicker.date];
        PassengerModel *models = mode;
        models.detailString = nowtimeStr;
        models.dataID = [NSString stringWithFormat:@"%ld",(long)[vc.datePicker.date timeIntervalSince1970]];
        [vc.carServerTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [vc.datePicker removeFromSuperview];
        vc.datePicker = nil;
    } andCancleAction:^(UIAlertAction *action) {
        
    } andOtherAction:^(UIAlertAction *action) {
        
    } okButtonIsNil:NO];
}

- (void)chooseCarType:(NSIndexPath *)indexPath{
    PassengerModel *model = self.tableViewArray[indexPath.section];
    self.selectModel = model;
    self.selectIndexPath = indexPath;
    __weak typeof(self) vc = self;
    [GzyCommenMetthod setActionSheetTitle:NSLocalizedString(@"carServerChooseCarType", nil) andMeesage:nil addView:nil inViewController:self buttonArray:@[NSLocalizedString(@"carServerFiveSeatCar", nil),NSLocalizedString(@"carServerSevenSeatCar", nil),NSLocalizedString(@"carServerTwelveSeatCar", nil)] andActionSheetTag:1 delegate:self andComplete:^(UIAlertAction *action) {
        
    } andCancleAction:^(UIAlertAction *action) { //取消
        
        
    } andOtherAction:^(UIAlertAction *action) {
        vc.selectModel.detailString = action.title;
        [vc.carServerTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    } okButtonIsNil:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1) {
        self.selectModel.detailString = @[NSLocalizedString(@"carServerFiveSeatCar", nil),NSLocalizedString(@"carServerSevenSeatCar", nil),NSLocalizedString(@"carServerTwelveSeatCar", nil)][buttonIndex];
        [self.carServerTableView reloadRowsAtIndexPaths:@[self.selectIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    if (actionSheet.tag == 2) {
        self.selectModel.detailString = @[NSLocalizedString(@"carServerHighway", nil),NSLocalizedString(@"carServerPlane", nil),NSLocalizedString(@"carServerTrain", nil)][buttonIndex];
        self.arriveType = @[NSLocalizedString(@"carServerHighway", nil),NSLocalizedString(@"carServerPlane", nil),NSLocalizedString(@"carServerTrain", nil)][buttonIndex];
        [self.carServerTableView reloadRowsAtIndexPaths:@[self.selectIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    if (actionSheet.tag == 3) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        if (self.selectPickerMode == UIDatePickerModeDateAndTime) {
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        }
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
        [formatter setTimeZone:timeZone];
        NSString *nowtimeStr = [formatter stringFromDate:self.datePicker.date];
        self.selectModel.detailString = nowtimeStr;
        self.selectModel.dataID = [NSString stringWithFormat:@"%ld",(long)[self.datePicker.date timeIntervalSince1970]];
        [self.carServerTableView reloadRowsAtIndexPaths:@[self.selectIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

-(void)dealloc{
    NSLog(@"asdfadfasdfasdfasdfafasfaf");
}

#pragma mark - 控件的初始化
- (UITableView *)carServerTableView{
    if (!_carServerTableView) {
        _carServerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 65-50) style:UITableViewStyleGrouped];
        [_carServerTableView registerClass:[AddpassengerTableViewCell class] forCellReuseIdentifier:@"cell1"];
        [_carServerTableView registerClass:[AddpassengerTableViewCell class] forCellReuseIdentifier:@"cell2"];
        [_carServerTableView registerClass:[HotboomTableViewCell class] forCellReuseIdentifier:@"imageCell"];
        _carServerTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        _carServerTableView.delegate = self;
        _carServerTableView.dataSource = self;
    }
    return _carServerTableView;
}

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        if(IOS9){
            _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH - 20, 300)];
        }else
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(-10, 10, SCREEN_WIDTH - 20, 300)];
    }
    return _datePicker;
}

- (SwpCamera *)camera{
    if (!_camera) {
        _camera = [[SwpCamera alloc] init];
    }
    return _camera;
}

@end
