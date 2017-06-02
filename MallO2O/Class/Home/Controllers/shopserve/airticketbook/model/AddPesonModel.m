//
//  AddPesonModel.m
//  MallO2O
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "AddPesonModel.h"

@implementation AddPesonModel

+ (instancetype)init:(NSDictionary *)dic{
    return [[AddPesonModel alloc] initFromNetDic:dic];
}

- (instancetype)initFromNetDic:(NSDictionary *)dic{
    AddPesonModel *model = [[AddPesonModel alloc] init];
    model.name = dic[@"name"];
    model.passport = dic[@"passport"];
    model.nationality = dic[@"nationality"];
    model.type = dic[@"type"];
    model.p_id = dic[@"p_id"];
    model.nationality_id = dic[@"nationality_id"];
    return model;
}


@end
