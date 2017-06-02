//
//  BigTradeSortModel.m
//  MallO2O
//
//  Created by songweiping on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeSortModel.h"

@implementation BigTradeSortModel



+ (instancetype)bigTradeSortWithBigTradeSortID:(NSString *)bigTradeSortID bigTradeSortName:(NSString *)bigTradeSortName bigTradeSortImage:(NSString *)bigTradeSortImage {
    
    BigTradeSortModel *bigTradeSort = [[self alloc] init];
    bigTradeSort.bigTradeCateID     = bigTradeSortID;
    bigTradeSort.bigTradeCateName   = bigTradeSortName;
    bigTradeSort.bigTradeSortImage  = bigTradeSortImage;
    
    return bigTradeSort;
}

+ (NSArray<BigTradeSortModel *> *)bigTradeSortWithArray {
    
    BigTradeSortModel *defaultSort  = [BigTradeSortModel bigTradeSortWithBigTradeSortID:@"0" bigTradeSortName:NSLocalizedString(@"bigTradeDefaultSortTitle", nil) bigTradeSortImage:@""];
    BigTradeSortModel *highestPrice = [BigTradeSortModel bigTradeSortWithBigTradeSortID:@"1" bigTradeSortName:NSLocalizedString(@"bigTradeHighestPriceSortTitle", nil) bigTradeSortImage:@""];
    BigTradeSortModel *lowestPrice  = [BigTradeSortModel bigTradeSortWithBigTradeSortID:@"2" bigTradeSortName:NSLocalizedString(@"bigTradeLowestPriceSortTitle", nil) bigTradeSortImage:@""];
    return @[defaultSort, highestPrice, lowestPrice];
}



@end
