//
//  CanlendarViewController.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/17.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@class FSCalendar;

typedef void(^CanlendarViewControllerBlock)(NSDate *date ,FSCalendar *calendar);

@interface CanlendarViewController : MallO2OBaseViewController

@property (copy ,nonatomic) CanlendarViewControllerBlock dateBlock;
- (void)clickDateAndGetIt:(CanlendarViewControllerBlock)block;

@end
