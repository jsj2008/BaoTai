//
//  CityModel.m
//  MallO2O
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

+ (instancetype)init:(NSDictionary *)dic{
    return [[CityModel alloc] initFromNetDic:dic];
}

- (instancetype)initFromNetDic:(NSDictionary *)dic{
    CityModel *model = [[CityModel alloc] init];
    model.cityID = dic[@"id"];
    model.cityName = dic[@"russian"];
    return model;
}


@end
