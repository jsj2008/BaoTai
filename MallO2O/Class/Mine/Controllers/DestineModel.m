//
//  DestineModel.m
//  MallO2O
//
//  Created by mac on 16/6/1.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "DestineModel.h"

@implementation DestineModel

+ (instancetype)init:(NSDictionary *)dic{
    return [[DestineModel alloc] initFromNetDic:dic];
}

- (instancetype)initFromNetDic:(NSDictionary *)dic{
    DestineModel *model = [[DestineModel alloc] init];
    model.back_time   = dic[@"back_time"];
    model.destination = dic[@"destination"];
    model.origin      = dic[@"origin"];
    model.out_time    = dic[@"out_time"];
    model.r_id        = dic[@"r_id"];
    model.type        = dic[@"type"];
    model.is_pay      = dic[@"is_pay"];
    model.url         = dic[@"url"];
    
    return model;
}

@end
