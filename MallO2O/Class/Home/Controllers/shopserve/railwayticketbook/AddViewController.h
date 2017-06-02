//
//  AddViewController.h
//  MallO2O
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"
#import "AddPesonModel.h"
@interface AddViewController : MallO2OBaseViewController

@property (weak ,nonatomic) AddPesonModel *personModel;

@property (copy ,nonatomic) NSArray *tableViewArray;

@property (nonatomic, assign) BOOL type;

@end
