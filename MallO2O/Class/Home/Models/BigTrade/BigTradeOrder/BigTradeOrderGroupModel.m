//
//  BigTradeOrderGroupModel.m
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeOrderGroupModel.h"

@implementation BigTradeOrderGroupModel

+ (instancetype)bigTradeOrderGroupModelWithTitle:(NSString *)bigTradeOrderGroupHeaderTitle bigTradeOrderDataSource:(NSArray *)bigTradeOrderGroupDataSource {
    
    BigTradeOrderGroupModel *bigTradeOrderGroup      = [[self  alloc] init];
    bigTradeOrderGroup.bigTradeOrderGroupHeaderTitle = bigTradeOrderGroupHeaderTitle;
    bigTradeOrderGroup.bigTradeOrderGroupDataSource  = bigTradeOrderGroupDataSource;
    return bigTradeOrderGroup;
}

@end
