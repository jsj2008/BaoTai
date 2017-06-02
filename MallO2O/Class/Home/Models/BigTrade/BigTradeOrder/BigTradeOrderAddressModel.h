//
//  BigTradeOrderAddressModel.h
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface BigTradeOrderAddressModel : NSObject

@property (nonatomic, copy) NSString *bigTradeOrderAddressTitle;
@property (nonatomic, copy) NSString *bigTradeOrderAddressSubTitle;

+ (instancetype)bigTradeOrderAddressWithTitle:(NSString *)bigTradeOrderAddressTitle subTitle:(NSString *)bigTradeOrderAddressSubTitle;

@end

NS_ASSUME_NONNULL_END
