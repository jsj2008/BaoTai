//
//  BigTradeOrderShopInfoModel.m
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeOrderShopInfoModel.h"

@implementation BigTradeOrderShopInfoModel

+ (instancetype)bigTradeOrderShopInfoWithTitle:(NSString *)bigTradeOrderShopInfoTitle subTitle:(NSString *)bigTradeOrderShopInfoSubTitle {
    
    BigTradeOrderShopInfoModel *bigTradeOrderShopInfo   = [[self alloc] init];
    bigTradeOrderShopInfo.bigTradeOrderShopInfoTitle    = bigTradeOrderShopInfoTitle;
    bigTradeOrderShopInfo.bigTradeOrderShopInfoSubTitle = bigTradeOrderShopInfoSubTitle;
    return bigTradeOrderShopInfo;
}

@end
