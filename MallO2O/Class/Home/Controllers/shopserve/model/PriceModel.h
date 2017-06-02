//
//  PriceModel.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/28.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceModel : NSObject

@property (copy ,nonatomic) NSString *insurancePrice;

@property (copy ,nonatomic) NSString *serverPrice;

/**
 *  快速初始化一个单利模型
 *
 *  @return 返回的是单利模型
 */
+ (PriceModel *)shareInstance;
/**
 *  单例存储数据
 *
 *  @param dic 存储数据来源 一般在登录接口
 *
 *  @return
 */
+ (instancetype)savePrice:(NSDictionary *)dic;

@end
