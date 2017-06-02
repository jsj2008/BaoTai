//
//  BigTradeOrderGroupModel.h
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface BigTradeOrderGroupModel : NSObject

@property (nonatomic, copy) NSString *bigTradeOrderGroupHeaderTitle;
@property (nonatomic, copy) NSArray  *bigTradeOrderGroupDataSource;

+ (instancetype)bigTradeOrderGroupModelWithTitle:(NSString *)bigTradeOrderHeaderTitle bigTradeOrderDataSource:(NSArray *)bigTradeOrderDataSource;


@end
NS_ASSUME_NONNULL_END
