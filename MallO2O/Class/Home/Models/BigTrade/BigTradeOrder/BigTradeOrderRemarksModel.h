//
//  BigTradeOrderRemarksModel.h
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BigTradeOrderRemarksModel : NSObject

@property (nonatomic, copy) NSString *bigTradeOrderRemarksPlaceholder;
+ (instancetype)bigTradeOrderRemarksWithPlaceholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
