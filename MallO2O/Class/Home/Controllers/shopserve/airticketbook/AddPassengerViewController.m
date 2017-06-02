//
//  AddPassengerViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/11.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "AddPassengerViewController.h"

#import "AddpassengerTableViewCell.h"
#import "SuperTableViewCell.h"
#import "PassengerModel.h"
#import "GzyCommenMetthod.h"
#import "NationalityCountryViewController.h"
#import "LoginViewController.h"

static __weak typeof(AddPassengerViewController *) selfVC;

@interface AddPassengerViewController ()<UITableViewDataSource ,UITableViewDelegate ,UIActionSheetDelegate>

@property (strong ,nonatomic) UITableView *addPassengerTableView;

@property (strong ,nonatomic) PassengerModel *selectModel;

@property (strong ,nonatomic) NSIndexPath *selectIndexPath;



@end

@implementation AddPassengerViewController{
//    NSArray *tableViewArray;
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
    [self.addPassengerTableView reloadData];
    
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    _selectIndexPath = [[NSIndexPath alloc] init];
    NSArray *array1           = [[NSArray alloc] init];
    NSArray *array2           = [[NSArray alloc] init];
    PassengerModel *model1    = [[PassengerModel alloc] init];
    model1.typeString         = NSLocalizedString(@"addPassengerCellNameTitle", nil);
    model1.placeholderString  = NSLocalizedString(@"addPassengerCellPlaceholder", nil);
    model1.detailString       = @"";
    model1.p_id               = @"";
    model1.textFieldCanEdit   = YES;

    PassengerModel *model2    = [[PassengerModel alloc] init];
    model2.typeString         = NSLocalizedString(@"addPassengerCellPassportNumbeTitle", nil);
    model2.placeholderString  = NSLocalizedString(@"addPassengerCellPleaseEnterYourPassportNumberPlaceholder", nil);
    model2.detailString       = @"";
    model2.textFieldCanEdit   = YES;

    PassengerModel *model3    = [[PassengerModel alloc] init];
    model3.typeString         = NSLocalizedString(@"addPassengerCellCountryCitizenshipTitle", nil);
    model3.dataID             = @"";
    model3.viewControllerName = @"";

    PassengerModel *model4    = [[PassengerModel alloc] init];
    model4.typeString         = NSLocalizedString(@"addPassengerCellPeopleType", nil);
    model4.viewControllerName = @"";
    model4.passengerType      = @"";
    
    if (self.personModel != nil) {
        
        if ([self.personModel.type isEqualToString:NSLocalizedString(@"addPassengerAdult", nil)]) {
            
            model4.passengerType = @"1";
        }
        if ([self.personModel.type isEqualToString:NSLocalizedString(@"addPassengerChildren", nil)]) {
            
            model4.passengerType = @"2";
        }
        model1.detailString = self.personModel.name;
        model2.detailString = self.personModel.passport;
        model3.typeString   = self.personModel.nationality;
        model3.dataID       = self.personModel.nationality_id;
        model4.typeString   = self.personModel.type;
        model1.p_id         = self.personModel.p_id;
        
        
    }
    
    array1                    = @[model1,model2];
    array2                    = @[model3,model4];
    _tableViewArray           = @[array1,array2];
    
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

- (void)setTableViewArray:(NSArray *)tableViewArray {
    
    _tableViewArray = tableViewArray;
}
/**
 *  设置导航控制器
 */
- (void) settingNav {
    if (self.personModel != nil) {
        
        [self setNavBarTitle:NSLocalizedString(@"alterPassengerNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    }
    else {
        
        [self setNavBarTitle:NSLocalizedString(@"addPassengerNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    }
    [self setBackButton];
//    self.navigationItem.rightBarButtonItem = [UZCommonMethod setButtonTitle:@"确定" andTitleSize:15 andTitleColor:[UIColor whiteColor]];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.addPassengerTableView];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
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
    __weak typeof(self)this = self;
    if (![self checkLogin]) {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }
    
    PassengerModel *model1 = _tableViewArray[0][0];
    PassengerModel *model2 = _tableViewArray[0][1];
    PassengerModel *model3 = _tableViewArray[1][0];
    PassengerModel *model4 = _tableViewArray[1][1];
    
    if (self.type == YES) {
        
        if ([model1.detailString isEqualToString:self.personModel.name] && [model2.detailString isEqualToString:self.personModel.passport] && [model3.dataID isEqualToString:self.personModel.nationality_id] && [model4.typeString isEqualToString:self.personModel.type]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        if (model1.detailString.length == 0 || model2.detailString.length == 0 || model3.dataID.length == 0 || model4.passengerType.length == 0) {
            
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"carServerCheckUserInputMessageTitle", nil)];
            return;
            
        }
        else {
        
            NSString *url = [SwpTools swpToolGetInterfaceURL:@"passenger_update"]; //192.168.1.66/baotaiapp_action/ac_reserve/passenger_update
            
            NSDictionary *dic = @{
                                  @"app_key"    :url,
                                  @"name"       :model1.detailString,
                                  @"nationality":model3.dataID,
                                  @"passport"   :model2.detailString,
                                  @"type"       :model4.passengerType,
                                  @"p_id"       :model1.p_id,
                                  @"u_id"       :[PersonInfoModel shareInstance].uID
                                  
                                  };
            
            NSLog(@"*******************%@",dic);
            
            [SwpRequest swpPOST:url parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
//                [SVProgressHUD showErrorWithStatus:resultObject[@"message"]];
                if ([resultObject[@"code"] integerValue] == 200) {
                    
                    [this.navigationController popViewControllerAnimated:YES];
                }
                
            } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
                
                
            }];
        }
        
        
        
        
    }else{
    
        if (model1.detailString.length == 0 || model2.detailString.length == 0 || model3.typeString.length == 0 || self.selectModel.typeString.length == 0) {
            
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"carServerCheckUserInputMessageTitle", nil)];
            return;
            
        }
        else {
            
            NSString *url = [SwpTools swpToolGetInterfaceURL:@"passenger_insert"];//@"192.168.1.66/baotaiapp_action/ac_reserve/passenger_insert";
            NSDictionary *dic1 = @{
                                  @"app_key"    :url,
                                  @"name"       :model1.detailString,
                                  @"nationality":model3.dataID,
                                  @"passport"   :model2.detailString,
                                  @"type"       :@"1",
                                  @"u_id"       :[PersonInfoModel shareInstance].uID
                                  
                                  };
            NSDictionary *dic2 = @{
                                  @"app_key"    :url,
                                  @"name"       :model1.detailString,
                                  @"nationality":model3.dataID,
                                  @"passport"   :model2.detailString,
                                  @"type"       :@"2",
                                  @"u_id"       :[PersonInfoModel shareInstance].uID
                                  
                                  };

            
            
            if ([model4.typeString isEqualToString:@"成人"]) {
                
                [SwpRequest swpPOST:url parameters:dic1 isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
                    
                    if ([resultObject[@"code"] integerValue] == 200) {
                        
                        [this.navigationController popViewControllerAnimated:YES];
                    }
                    
                } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
                    
                    NSLog(@"%@",error);
                    
                }];
            }
            if ([model4.typeString isEqualToString:@"儿童"]) {
                
                [SwpRequest swpPOST:url parameters:dic2 isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
                    
                    if ([resultObject[@"code"] integerValue] == 200) {
                        
                        [this.navigationController popViewControllerAnimated:YES];
                    }
                    
                } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
                    
                    NSLog(@"%@",error);
                    
                }];

                
            }
            
            
        }
        
    }
    
}




#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _tableViewArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = _tableViewArray[section];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
    {
        AddpassengerTableViewCell *cell = [AddpassengerTableViewCell addPassengerCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellIdentifier:@"cell"];
        PassengerModel *model = _tableViewArray[indexPath.section][indexPath.row];
        cell.addModel = model;
        
        [cell getAddpassengerTableViewCellBlock:^(NSString *inputText, NSInteger index, NSInteger indexRow) {
            PassengerModel *model = _tableViewArray[index][indexRow];
            if (indexRow == 0) {
                
                model.detailString = inputText;
                
            }
            if (indexRow == 1) {
                
                model.detailString = inputText;
                
            }

            
        }];
        
//        [cell getAddpassengerTableViewCellBlock:^(NSString *inputText, NSInteger index) {
//            
//           
////            NSLog(@"%@%ld",inputText,index);
//        }];
        return cell;
    }else{
        SuperTableViewCell *cell = [SuperTableViewCell superCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellIdentifier:@"superCell"];
        cell.superModel = _tableViewArray[indexPath.section][indexPath.row];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 40)];
//        [cell.contentView addSubview:label];
//        label.font = [UIFont systemFontOfSize:15];
//        label.textAlignment = NSTextAlignmentRight;
//        label.textColor = UIColorFromRGB(0x888888);
//        label.text = cell.superModel.detailString;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) selfVc = self;

    if (indexPath.section == 1 && indexPath.row == 0 ) {
        PassengerModel *model = _tableViewArray[indexPath.section][indexPath.row];
        
        NationalityCountryViewController *vc = [[NationalityCountryViewController alloc] init];
        
        [vc getCountryNameAndCountryID:^(NSString *countryName, NSString *countryID) {
            model.typeString = countryName;
            model.dataID = countryID;
            [selfVc.addPassengerTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }];

        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        PassengerModel *model = _tableViewArray[indexPath.section][indexPath.row];
        self.selectModel = model;
        self.selectIndexPath = indexPath;
        __weak typeof(self) vc = self;
        [GzyCommenMetthod setActionSheetTitle:NSLocalizedString(@"addPassengerCellPeopleType", nil) andMeesage:nil addView:nil inViewController:self buttonArray:@[NSLocalizedString(@"addPassengerAdult", nil),NSLocalizedString(@"addPassengerChildren", nil)] andActionSheetTag:1 delegate:self andComplete:^(UIAlertAction *action) {
            
        } andCancleAction:^(UIAlertAction *action) {
            
        } andOtherAction:^(UIAlertAction *action) {
//            vc.selectModel.typeString = action.title;
            model.typeString = action.title;
            if ([model.typeString isEqualToString:NSLocalizedString(@"addPassengerAdult", nil)]) {
                
                model.passengerType = @"1";
            }
            else {
                model.passengerType = @"2";
            }
            NSLog(@"---------------------%@",model.typeString);
            [vc.addPassengerTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        } okButtonIsNil:YES];
        
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 1) {
       
        self.selectModel.detailString = @[NSLocalizedString(@"addPassengerAdult", nil),NSLocalizedString(@"addPassengerChildren", nil)][buttonIndex];
        [self.addPassengerTableView reloadRowsAtIndexPaths:@[self.selectIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    }
}



#pragma mark - 控件初始化
- (UITableView *)addPassengerTableView{
    if (!_addPassengerTableView) {
        _addPassengerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60) style:UITableViewStyleGrouped];
        [_addPassengerTableView registerClass:[AddpassengerTableViewCell class] forCellReuseIdentifier:@"cell"];
        [_addPassengerTableView registerClass:[SuperTableViewCell class] forCellReuseIdentifier:@"superCell"];
        _addPassengerTableView.delegate = self;
        _addPassengerTableView.dataSource = self;
    }
    return _addPassengerTableView;
}

@end
