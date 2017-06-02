//
//  AddPassengerViewController.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/11.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

#import "AddPesonModel.h"

@interface AddPassengerViewController : MallO2OBaseViewController

@property (weak ,nonatomic) AddPesonModel *personModel;

@property (copy ,nonatomic) NSArray *tableViewArray;

@property (nonatomic, assign) BOOL type;

@end
