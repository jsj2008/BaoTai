//
//  RailwayTicketBookViewController.m
//  MallO2O
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "RailwayTicketBookViewController.h"
//车次列表
#import "TrainViewController.h"
#import "GoAndBackTrainTicketViewController.h"
//预定 web
#import "WebDestineViewController.h"
#import "LoginViewController.h"

#import "InternationalCityViewController.h"
static __weak typeof(RailwayTicketBookViewController *) selfVC;

@interface RailwayTicketBookViewController ()

@property (strong ,nonatomic) UIDatePicker *datePicker;

@property (copy ,nonatomic) NSString *goOnCityID;
@property (copy ,nonatomic) NSString *arriveCityID;

// 时间戳
@property (copy ,nonatomic) NSString *goOnTimeSp;
@property (copy ,nonatomic) NSString *backTimeSp;

@end

@implementation RailwayTicketBookViewController{
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
    [self.view setBackgroundColor:UIColorFromRGB(0xf4f4f4)];
    self.grayView.hidden = YES;
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    selfVC = self;
    isSingle = YES;
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
    [self setViewGesture];
    [self setCityGesture];
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"railwayBookNavigationTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/**
 *  添加控件
 */
- (void) addUI {
    
}
/**
 *  设置控件样式
 */
- (void)setUI{
    self.travelView.layer.borderWidth   = 0.8;
    self.travelView.layer.borderColor   = UIColorFromRGB(0xc0c0c0).CGColor;
    
    self.commitButton.layer.borderColor = UIColorFromRGB(0xc0c0c0).CGColor;
    
    y       = self.backTimeLabel.frame.origin.y;
    height  = self.backTimeLabel.frame.size.height;
    width   = self.arriveCityLabel.frame.size.width;
    
    [self.singleTravelButton setTitle:NSLocalizedString(@"railwayBookOne-WayTitle", nil) forState:UIControlStateNormal];
    [self.singleTravelButton setTitle:NSLocalizedString(@"railwayBookOne-WayTitle", nil) forState:UIControlStateHighlighted];
    
    [self.returnTravelButton setTitle:NSLocalizedString(@"railwayBookRoundTripTitle", nil) forState:UIControlStateNormal];
    [self.returnTravelButton setTitle:NSLocalizedString(@"railwayBookRoundTripTitle", nil) forState:UIControlStateHighlighted];
    
    self.goOnCityLabel.text   = NSLocalizedString(@"railwayBookDepartureCityTitle", nil);
    self.arriveCityLabel.text = NSLocalizedString(@"railwayBookArrivalCityTitle", nil);
    
    self.chooseLabel.text     = NSLocalizedString(@"railwayBookSelectADateTitle", nil);
    self.backTimeLabel.text   = NSLocalizedString(@"railwayBookReturnTimeTitle", nil);
    
    [self.commitButton setTitle:NSLocalizedString(@"railwayBookSearchButtonTitle", nil) forState:UIControlStateNormal];
    [self.commitButton setTitle:NSLocalizedString(@"planeBookSearchButtonTitle", nil) forState:UIControlStateHighlighted];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

// 选择城市label 的单击手势
- (void)setCityGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    self.goOnCityLabel.userInteractionEnabled = YES;
    [self.goOnCityLabel addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    self.arriveCityLabel.userInteractionEnabled = YES;
    [self.arriveCityLabel addGestureRecognizer:tapGesture1];
    
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture {
    
    InternationalCityViewController *vc = [[InternationalCityViewController alloc] init];
    
    if (tapGesture.view.tag == 1) {
        
        [vc getCityNameAndCityID:^(NSString *cityName, NSString *cityID) {
            
            selfVC.goOnCityLabel.text = cityName;
            selfVC.goOnCityID = cityID;
            
        }];
    }
    if (tapGesture.view.tag == 2) {
        
        [vc getCityNameAndCityID:^(NSString *cityName, NSString *cityID) {
            
            selfVC.arriveCityLabel.text = cityName;
            selfVC.arriveCityID = cityID;
            
        }];
    }
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)setViewGesture{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGoDate:)];
    self.chooseLabel.userInteractionEnabled = YES;
    [self.chooseLabel addGestureRecognizer:gesture];
    UITapGestureRecognizer *backGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGoDate:)];
    self.backTimeLabel.userInteractionEnabled = YES;
    [self.backTimeLabel addGestureRecognizer:backGesture];
}

- (void)clickGoDate:(UITapGestureRecognizer *)gesture{
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    UILabel *label = (UILabel *)gesture.view;
    [GzyCommenMetthod setActionSheetTitle:NSLocalizedString(@"planeBookPleaseChooseTime", nil) andMeesage:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" addView:self.datePicker inViewController:self buttonArray:nil andActionSheetTag:1 delegate:self andComplete:^(UIAlertAction *action) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
        [formatter setTimeZone:timeZone];
        NSString *nowtimeStr = [formatter stringFromDate:selfVC.datePicker.date];
        label.text = [NSString stringWithFormat:@"%@",nowtimeStr];
        if (label.tag == 5) {
            
            selfVC.goOnTimeSp = [NSString stringWithFormat:@"%ld", (long)[selfVC.datePicker.date timeIntervalSince1970]];
        }
        if (label.tag == 6) {
            
            selfVC.backTimeSp = [NSString stringWithFormat:@"%ld", (long)[selfVC.datePicker.date timeIntervalSince1970]];
        }

    } andCancleAction:^(UIAlertAction *action) {
        
    } andOtherAction:^(UIAlertAction *action) {
        
    } okButtonIsNil:NO];
}

- (void)settingNoticeViewFrameFromButton:(id)sender{
    UIButton *button = (UIButton *)sender;
    [UIView animateWithDuration:0.3 animations:^{
        self.noticeView.center = CGPointMake(button.center.x, 43);
        
    }];
}
// 点击单程按钮
- (IBAction)singleTravelButton:(UIButton *)sender {
    
    [self settingNoticeViewFrameFromButton:sender];
    [self.singleTravelButton setTitleColor:UIColorFromRGB(0x1a9ded) forState:UIControlStateNormal];
    [self.returnTravelButton setTitleColor:UIColorFromRGB(0x343434) forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.chooseLabel.text = NSLocalizedString(@"planeBookSelectADateTitle", nil);
        self.backTimeLabel.frame = CGRectMake(SCREEN_WIDTH, y, width*Balance_Width, height);
        self.backTimeLabel.text   = NSLocalizedString(@"planeBookReturnTimeTitle", nil);
    }];
    isSingle = YES;

}

// 点击往返按钮
- (IBAction)returnTravelButton:(UIButton *)sender {
    
    [self settingNoticeViewFrameFromButton:sender];
    [self.singleTravelButton setTitleColor:UIColorFromRGB(0x343434) forState:UIControlStateNormal];
    [self.returnTravelButton setTitleColor:UIColorFromRGB(0x1a9ded) forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.chooseLabel.text = NSLocalizedString(@"planeBookTripDatesTitle", nil);
        self.backTimeLabel.text   = NSLocalizedString(@"planeBookReturnTimeTitle", nil);
        self.backTimeLabel.frame = CGRectMake(self.arriveCityLabel.frame.origin.x , y, width*Balance_Width, height);
    }];
    isSingle = NO;
}

// 点击搜搜按钮
- (IBAction)clickCommit:(UIButton *)sender {

    if (![self checkLogin]) {
        LoginViewController *viewController = [[LoginViewController alloc] init];
        [viewController setBackButton];
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }

    
    
        WebDestineViewController *vc = [[WebDestineViewController alloc] init];
    
        if (isSingle) {
            
            if (self.goOnCityID == nil || self.arriveCityID == nil || self.goOnTimeSp == nil ) {
                
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"carServerCheckUserInputMessageTitle", nil)];
                return;
            }
    
            NSString *str = [NSString stringWithFormat:@"type=%@&u_id=%@&origin_id=%@&destination_id=%@&out_time=%@",@"1",[PersonInfoModel shareInstance].uID,self.goOnCityID,self.arriveCityID,self.goOnTimeSp];
    
            vc.body = str;
    
        }
        else {
            
            if (self.goOnCityID == nil || self.arriveCityID == nil || self.goOnTimeSp == nil || self.backTimeSp == nil) {
                
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"carServerCheckUserInputMessageTitle", nil)];
                return;
            }
            if ([self.chooseLabel.text isEqual: self.backTimeLabel.text]) {
                
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"planeBookRightTimeMessageTitle", nil)];
                return;
            }

            NSString *str = [NSString stringWithFormat:@"type=%@&u_id=%@&origin_id=%@&destination_id=%@&out_time=%@&back_time=%@",@"2",[PersonInfoModel shareInstance].uID,self.goOnCityID,self.arriveCityID,self.goOnTimeSp,self.backTimeSp];
    
            vc.body = str;
            
        }

 
//    TrainViewController *vc = [[TrainViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
   
}

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 300)];
        NSDate *date = [NSDate date];
        _datePicker.minimumDate = date;
    }
    return _datePicker;
}

@end
