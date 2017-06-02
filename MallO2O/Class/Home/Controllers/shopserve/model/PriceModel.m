//
//  PriceModel.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/28.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "PriceModel.h"

@implementation PriceModel

static PriceModel *model = nil;

+ (PriceModel *)shareInstance{
    @synchronized(self) {
        if (model == nil) {
            model = [[PriceModel alloc] init];
        }
        if (model.insurancePrice == nil) {
            model.insurancePrice = @"0";
        }
        if (model.serverPrice == nil) {
            model.serverPrice = @"0";
        }
        return model;
    }
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self) {
        model = [super allocWithZone:zone];
    }
    return model;
}

+ (instancetype)savePrice:(NSDictionary *)dic{
    PriceModel *model = [PriceModel shareInstance];
    model.insurancePrice = dic[@"invitation_price"];
    model.serverPrice = dic[@"pickup_service"];
    return model;
}

@end
