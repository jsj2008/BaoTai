//
//  SeeGoodsHistoryModel.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/28.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "SeeGoodsHistoryModel.h"

@implementation SeeGoodsHistoryModel

+ (instancetype)arrayWithDic:(NSDictionary *)dic{
    return [[SeeGoodsHistoryModel alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.secondGoodsId = dic[@"goods_id"];
        self.secondImgUrlText = dic[@"goods_img"];
        self.secondNowPriceText = dic[@"price"];
        self.secondTitleText = dic[@"goods_name"];
        self.secondShopName = dic[@"sale"];
//        self.second = dic[@"sale"];
        self.isHot = dic[@"is_hot"];
        self.webUrl = dic[@"message_url"];
    }
    return self;
}

@end
