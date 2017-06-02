//
//  BigTradeViewController.h
//  MallO2O
//
//  Created by songweiping on 16/3/21.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface BigTradeViewController : MallO2OBaseViewController

/**
 *  判断大件  酒店预订  餐饮预订的类型
 */
@property (copy ,nonatomic) NSString *listType;

@property (copy ,nonatomic) NSString *navigationTitle;

@end
