//
//  ValidityModel.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/15.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "ValidityModel.h"

@implementation ValidityModel

+ (instancetype)setValidityType:(NSString *)validityType validityTimeOne:(NSString *)validityTimeOne validityTimeTwo:(NSString *)validityTimeTwo validityTimeThree:(NSString *)validityTimeThree{
    ValidityModel *model = [[ValidityModel alloc] init];
    model.validityTimeOne   = validityTimeOne;
    model.validityTimeThree = validityTimeThree;
    model.validityTimeTwo   = validityTimeTwo;
    model.validityType      = validityType;
    return model;
}

@end
