//
//  BigTradeOrderAddressModel.m
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeOrderAddressModel.h"

@implementation BigTradeOrderAddressModel


+ (instancetype)bigTradeOrderAddressWithTitle:(NSString *)bigTradeOrderAddressTitle subTitle:(NSString *)bigTradeOrderAddressSubTitle {
    
    BigTradeOrderAddressModel *bigTradeOrderAddress   = [[self alloc] init];
    bigTradeOrderAddress.bigTradeOrderAddressTitle    = bigTradeOrderAddressTitle;
    bigTradeOrderAddress.bigTradeOrderAddressSubTitle = bigTradeOrderAddressSubTitle;
    return bigTradeOrderAddress;
}


@end
