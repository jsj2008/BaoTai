//
//  BigTradeOrderShopInfoModel.h
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BigTradeOrderShopInfoModel : NSObject

@property (nonatomic, copy) NSString *bigTradeOrderShopInfoTitle;
@property (nonatomic, copy) NSString *bigTradeOrderShopInfoSubTitle;

+ (instancetype)bigTradeOrderShopInfoWithTitle:(NSString *)bigTradeOrderShopInfoTitle subTitle:(NSString *)bigTradeOrderShopInfoSubTitle;


@end

NS_ASSUME_NONNULL_END
