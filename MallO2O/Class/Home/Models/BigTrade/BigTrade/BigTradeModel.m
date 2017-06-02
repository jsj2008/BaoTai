//
//  BigTradeModel.m
//  MallO2O
//
//  Created by songweiping on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeModel.h"

@implementation BigTradeModel


+ (instancetype)bigTradeWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _bigTradeID       = dictionary[@"goods_id"];
        _bigTradeName     = dictionary[@"goods_name"];
        _bigTradePrice    = dictionary[@"price"];
        _bigTradeInfoURL  = dictionary[@"message_url"];
        _bigTradeImageURL = dictionary[@"goods_img"];
    }
    return self;
}


+ (NSMutableArray<BigTradeModel *> *)bigTradeWithArray:(NSArray<NSDictionary *> *)dictionaryArray {
    
    return [BigTradeModel bigTradeWithArray:dictionaryArray accedeToArray:[NSArray array]];
}

+ (NSMutableArray<BigTradeModel *> *)bigTradeWithArray:(NSArray<NSDictionary *> *)dictionaryArray accedeToArray:(NSArray<BigTradeModel *> *)oldDataArray {
    NSMutableArray *arrayModel = [NSMutableArray arrayWithArray:oldDataArray];
    [dictionaryArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrayModel addObject:[[self alloc] initWithDictionary:obj]];
    }];
    
    return arrayModel;
}


@end
