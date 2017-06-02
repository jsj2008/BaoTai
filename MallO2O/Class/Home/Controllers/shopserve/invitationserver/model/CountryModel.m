//
//  CountryModel.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "CountryModel.h"

@implementation CountryModel

+ (instancetype)init:(NSDictionary *)dic{
    return [[CountryModel alloc] initFromNetDic:dic];
}

- (instancetype)initFromNetDic:(NSDictionary *)dic{
    CountryModel *model = [[CountryModel alloc] init];
    model.coutryID = dic[@"id"];
    model.coutryName = dic[@"nationality"];
    return model;
}

@end
