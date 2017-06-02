//
//  PassengerModel.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/11.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "PassengerModel.h"

@implementation PassengerModel

+ (instancetype)setPassengerModel:(NSString *)typeString p_id:(NSString *)p_id passengerType:(NSString *)passengerType detailString:(NSString *)detailString placeHolder:(NSString *)palceHolder cellAccessoryType:(UITableViewCellAccessoryType)cellAccessoryType pushViewControllerName:(NSString *)vcName{
    PassengerModel *model = [[PassengerModel alloc] init];
    model.typeString = typeString;
    model.detailString = detailString;
    model.placeholderString = palceHolder;
    model.cellAccessoryType = cellAccessoryType;
    model.viewControllerName = vcName;
    model.p_id = p_id;
    model.passengerType = passengerType;
    return model;
}

@end
