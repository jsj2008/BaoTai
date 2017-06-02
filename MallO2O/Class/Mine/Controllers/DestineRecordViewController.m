//
//  DestineRecordViewController.m
//  MallO2O
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "DestineRecordViewController.h"
#import "DestineTableViewCell.h"
#import "DestineModel.h"
#import "WebController.h"
@interface DestineRecordViewController ()<UITableViewDelegate ,UITableViewDataSource>

// 列表
@property (strong ,nonatomic)UITableView *destineRecordTableView;

@property (retain ,nonatomic) NSMutableArray *tableViewArray;

//@property (assign ,nonatomic) BOOL isOK;

@end

@implementation DestineRecordViewController {
    
    float x,y,width,height;
    BOOL isSingle;
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
    [self.view setBackgroundColor:UIColorFromRGB(0xf4f4f4)];
//    [self initData];
    
    [self.destineRecordTableView reloadData];
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    isSingle = YES;
    __weak typeof(self)selfVC = self;
//    if (isSingle == YES) {
        NSString *strUrl = [SwpTools swpToolGetInterfaceURL:@"reserve_list"]; //192.168.1.66/baotaiapp_action/ac_reserve/reserve_list
        NSDictionary *dic = @{
                              @"app_key" : strUrl,
                              @"ticket"  : @"1",
                              @"u_id"    : [PersonInfoModel shareInstance].uID
                              };
        [SwpRequest swpPOST:strUrl parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
            if ([resultObject[@"code"] integerValue] == 200) {
                
                NSLog(@"+++++++++++++%@",resultObject[@"obj"]);
                 selfVC.tableViewArray = [selfVC modelArrayFromResultObject:resultObject[@"obj"]];
                [selfVC.destineRecordTableView reloadData];
                
            }
            
        } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
           
            
        }];
        
}

- (NSMutableArray *)modelArrayFromResultObject:(NSMutableArray *)resultObject{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *dic in resultObject) {
        DestineModel *model = [DestineModel init:dic];
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
    [self setUI];

}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"destineRecordViewNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];

    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    
    [self.view addSubview:self.destineRecordTableView];
}
/**
 *  设置控件样式
 */
- (void)setUI{
    self.travelView.layer.borderWidth   = 0.8;
    self.travelView.layer.borderColor   = UIColorFromRGB(0xc0c0c0).CGColor;
    
    [self.planeButton setTitle:NSLocalizedString(@"destineRecordPlaneTicketTitle", nil) forState:UIControlStateNormal];
    [self.planeButton setTitle:NSLocalizedString(@"destineRecordPlaneTicketTitle", nil) forState:UIControlStateHighlighted];
    
    [self.trainButton setTitle:NSLocalizedString(@"destineRecordTrainTicketTitle", nil) forState:UIControlStateNormal];
    [self.trainButton setTitle:NSLocalizedString(@"destineRecordTrainTicketTitle", nil) forState:UIControlStateHighlighted];
    
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}


- (void)settingNoticeViewFrameFromButton:(id)sender{
    UIButton *button = (UIButton *)sender;
    [UIView animateWithDuration:0.3 animations:^{
        self.noticeView.center = CGPointMake(button.center.x, 43);
        
    }];
}

- (IBAction)planeButton:(UIButton *)sender {
    
    [self.destineRecordTableView reloadData];
    [self settingNoticeViewFrameFromButton:sender];
    [self.planeButton setTitleColor:UIColorFromRGB(0x1a9ded) forState:UIControlStateNormal];
    [self.trainButton setTitleColor:UIColorFromRGB(0x343434) forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
//        self.chooseLabel.text = NSLocalizedString(@"planeBookSelectADateTitle", nil);
//        self.backTimeLabel.frame = CGRectMake(SCREEN_WIDTH, y, width*Balance_Width, height);
//        self.backTimeLabel.text   = NSLocalizedString(@"planeBookReturnTimeTitle", nil);
    }];
    
    __weak typeof(self)selfVC = self;
    NSString *strUrl = [SwpTools swpToolGetInterfaceURL:@"reserve_list"]; //192.168.1.66/baotaiapp_action/ac_reserve/reserve_list
    NSDictionary *dic = @{
                          @"app_key" : strUrl,
                          @"ticket"  : @"1",
                          @"u_id"    : [PersonInfoModel shareInstance].uID
                          };
    [SwpRequest swpPOST:strUrl parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if ([resultObject[@"code"] integerValue] == 200) {
            
            selfVC.tableViewArray = [selfVC modelArrayFromResultObject:resultObject[@"obj"]];
            [selfVC.destineRecordTableView reloadData];
            
        }
        
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
        
    }];

    
    
    
//    [self reloadPlane];
    
    isSingle = YES;

}

- (void)reloadPlane {
    
    
}

- (IBAction)trainButton:(UIButton *)sender {
    
    [self settingNoticeViewFrameFromButton:sender];
    [self.planeButton setTitleColor:UIColorFromRGB(0x343434) forState:UIControlStateNormal];
    [self.trainButton setTitleColor:UIColorFromRGB(0x1a9ded) forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
//        self.chooseLabel.text = NSLocalizedString(@"planeBookTripDatesTitle", nil);
//        self.backTimeLabel.text   = NSLocalizedString(@"planeBookReturnTimeTitle", nil);
//        self.backTimeLabel.frame = CGRectMake(self.arriveCityLabel.frame.origin.x , y, width*Balance_Width, height);
    }];
    
    __weak typeof(self)selfVC = self;
    NSString *strUrl = [SwpTools swpToolGetInterfaceURL:@"reserve_list"]; //192.168.1.66/baotaiapp_action/ac_reserve/reserve_list
    NSDictionary *dic = @{
                          @"app_key" : strUrl,
                          @"ticket"  : @"2",
                          @"u_id"    : [PersonInfoModel shareInstance].uID
                          };
    [SwpRequest swpPOST:strUrl parameters:dic isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if ([resultObject[@"code"] integerValue] == 200) {
            
            selfVC.tableViewArray = [selfVC modelArrayFromResultObject:resultObject[@"obj"]];
            [selfVC.destineRecordTableView reloadData];
            
        }
        
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
        
    }];
    
//    [self reloadTrain];
    
}

//- (void)reloadTrain {
//    
//    
//    
//}


#pragma mark -  delegate and  dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DestineTableViewCell *cell = [DestineTableViewCell destineCellOfTableView:tableView cellForRowAtIndexPath:indexPath andCellID:@"cell"];
    
    cell.model = self.tableViewArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0f * Balance_Heith;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0f * Balance_Heith;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WebController *vc = [[WebController alloc] init];
    
    vc.model = self.tableViewArray[indexPath.row];

    [self.navigationController pushViewController:vc animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

// 删除单元格
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        __weak typeof(self)this = self;
        NSString *url = [SwpTools swpToolGetInterfaceURL:@"reserve_del"]; // 192.168.1.66/baotaiapp_action/ac_reserve/reserve_del
        NSDictionary *dic = @{
                              @"app_key"    :url,
                              @"u_id"       :[PersonInfoModel shareInstance].uID,
                              @"r_id"       :[_tableViewArray[indexPath.row] r_id],
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




// 懒加载  45*Balance_Heith
- (UITableView *)destineRecordTableView {
    
    if (!_destineRecordTableView) {
        
        _destineRecordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45*Balance_Heith, SCREEN_WIDTH, SCREEN_HEIGHT - 106) style:UITableViewStyleGrouped];
        [_destineRecordTableView registerClass:[DestineTableViewCell class] forCellReuseIdentifier:@"cell"];
        _destineRecordTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        _destineRecordTableView.delegate   = self;
        _destineRecordTableView.dataSource = self;
    }
    
    return _destineRecordTableView;
}



@end
