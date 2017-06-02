//
//  ValidityModel.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/15.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidityModel : NSObject
/**
 *  邀请函类型
 */
@property (copy ,nonatomic) NSString *validityType;
/**
 *  有效期第一个时间
 */
@property (copy ,nonatomic) NSString *validityTimeOne;
/**
 *  有效期第二个时间
 */
@property (copy ,nonatomic) NSString *validityTimeTwo;
/**
 *  有效期第三个时间
 */
@property (copy ,nonatomic) NSString *validityTimeThree;

+ (instancetype)setValidityType:(NSString *)validityType validityTimeOne:(NSString *)validityTimeOne validityTimeTwo:(NSString *)validityTimeTwo validityTimeThree:(NSString *)validityTimeThree;

@end
