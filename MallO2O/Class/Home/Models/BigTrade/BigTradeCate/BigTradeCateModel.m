//
//  BigTradeCateModel.m
//  MallO2O
//
//  Created by songweiping on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeCateModel.h"

@implementation BigTradeCateModel

+ (instancetype)bigTradeCateWihtDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        _bigTradeCateID   = dictionary[@"cate_id"];
        _bigTradeCateName = dictionary[@"cate_name"];
    }
    
    return self;
}


+ (instancetype)bigTradeCateWithBigTradeCateID:(NSString *)bigTradeCateID bigTradeCateName:(NSString *)bigTradeCateName {
    

    BigTradeCateModel *bigTradeCate = [[self alloc] init];

    bigTradeCate.bigTradeCateID     = bigTradeCateID;
    bigTradeCate.bigTradeCateName   = bigTradeCateName;
    return bigTradeCate;
}


+ (NSArray<BigTradeCateModel *> *)bigTradeCateWihtArray:(NSArray<NSDictionary *> *)dictionaryArray {

    NSMutableArray  *arrayModel = [NSMutableArray array];
    [dictionaryArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrayModel addObject:[BigTradeCateModel bigTradeCateWihtDictionary:obj]];
    }];
    
    [arrayModel insertObject:[BigTradeCateModel bigTradeCateWithBigTradeCateID:@"0" bigTradeCateName:NSLocalizedString(@"bigTradeAllCategoriesTitle", nil)] atIndex:0];
    
    return [NSArray arrayWithArray:arrayModel];
}

@end
