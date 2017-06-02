//
//  CityModel.h
//  MallO2O
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

/**
 *  城市名称
 */
@property (copy ,nonatomic) NSString *cityName;
/**
 *  城市ID
 */
@property (copy ,nonatomic) NSString *cityID;

+ (instancetype)init:(NSDictionary *)dic;



@end
