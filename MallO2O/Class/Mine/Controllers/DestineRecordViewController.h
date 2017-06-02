//
//  DestineRecordViewController.h
//  MallO2O
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface DestineRecordViewController : MallO2OBaseViewController

@property (weak, nonatomic) IBOutlet UIView *travelView;

// 机票按钮
@property (weak, nonatomic) IBOutlet UIButton *planeButton;

// 火车票按钮
@property (weak, nonatomic) IBOutlet UIButton *trainButton;

// 按钮下边提示的view
@property (weak, nonatomic) IBOutlet UIView *noticeView;

- (IBAction)planeButton:(UIButton *)sender;

- (IBAction)trainButton:(UIButton *)sender;



@end
