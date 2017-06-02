//
//  PlaneBookViewController.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/10.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface PlaneBookViewController : MallO2OBaseViewController
/**
 *  飞程视图
 */
@property (weak, nonatomic) IBOutlet UIView *travelView;
/**
 *  单程按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *singleTravelButton;
/**
 *  往返按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *returnTravelButton;
/**
 *  出发城市label
 */
@property (weak, nonatomic) IBOutlet UILabel *goOnCityLabel;
/**
 *  到达城市label
 */
@property (weak, nonatomic) IBOutlet UILabel *arriveCityLabel;
/**
 *  选择日期label
 */
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;
/**
 *  搜搜按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
/**
 *  点击搜索按钮
 *
 *  @param sender 按钮
 */
- (IBAction)clickCommitButton:(id)sender;

/**
 *  返程时间label
 */
@property (weak, nonatomic) IBOutlet UILabel *backTimeLabel;
/**
 *  点击单程按钮
 *
 *  @param sender 按钮
 */
- (IBAction)clickSingleButton:(id)sender;
/**
 *  点击往返按钮
 *
 *  @param sender 按钮
 */
- (IBAction)clickReturnButton:(id)sender;
/**
 *  按钮下面的提示view
 */
@property (weak, nonatomic) IBOutlet UIView *noticeView;

@property (weak, nonatomic) IBOutlet UIView *grayView;



@end
