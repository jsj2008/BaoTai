//
//  BigTradeOrderRemarksModel.m
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeOrderRemarksModel.h"


@implementation BigTradeOrderRemarksModel

+ (instancetype)bigTradeOrderRemarksWithPlaceholder:(NSString *)placeholder {
    
    BigTradeOrderRemarksModel *bigTradeOrderRemarks      = [[self alloc] init];

    bigTradeOrderRemarks.bigTradeOrderRemarksPlaceholder = placeholder;

    return bigTradeOrderRemarks;
}

@end

