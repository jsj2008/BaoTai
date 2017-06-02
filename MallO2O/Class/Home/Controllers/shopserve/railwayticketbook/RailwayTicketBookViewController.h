//
//  RailwayTicketBookViewController.h
//  MallO2O
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface RailwayTicketBookViewController : MallO2OBaseViewController
// 火车视图
@property (weak, nonatomic) IBOutlet UIView *travelView;

// 单程按钮
@property (weak, nonatomic) IBOutlet UIButton *singleTravelButton;

// 往返按钮
@property (weak, nonatomic) IBOutlet UIButton *returnTravelButton;

// 出发城市label
@property (weak, nonatomic) IBOutlet UILabel *goOnCityLabel;

// 到达城市label
@property (weak, nonatomic) IBOutlet UILabel *arriveCityLabel;

// 选择时间label
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;

// 搜搜按钮
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

// 返城时间label
@property (weak, nonatomic) IBOutlet UILabel *backTimeLabel;

// 点击搜搜按钮
- (IBAction)clickCommit:(UIButton *)sender;

// 点击单程按钮
- (IBAction)singleTravelButton:(UIButton *)sender;
// 点击往返按钮
- (IBAction)returnTravelButton:(UIButton *)sender;

// 按钮下边的提示view
@property (weak, nonatomic) IBOutlet UIView *noticeView;


@property (weak, nonatomic) IBOutlet UIView *grayView;


@end
