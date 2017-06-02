//
//  BigTradeSortModel.h
//  MallO2O
//
//  Created by songweiping on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//



#import "BigTradeCateModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface BigTradeSortModel : BigTradeCateModel


@property (nonatomic, copy) NSString *bigTradeSortImage;


+ (instancetype)bigTradeSortWithBigTradeSortID:(NSString *)bigTradeSortID bigTradeSortName:(NSString *)bigTradeSortName bigTradeSortImage:(NSString *)bigTradeSortImage;

+ (NSArray<BigTradeSortModel *> *)bigTradeSortWithArray;

@end

NS_ASSUME_NONNULL_END
