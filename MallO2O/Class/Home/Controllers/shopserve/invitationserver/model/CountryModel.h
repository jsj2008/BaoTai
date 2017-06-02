//
//  CountryModel.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryModel : NSObject
/**
 *  国家名称
 */
@property (copy ,nonatomic) NSString *coutryName;
/**
 *  国家ID
 */
@property (copy ,nonatomic) NSString *coutryID;

+ (instancetype)init:(NSDictionary *)dic;

@end
