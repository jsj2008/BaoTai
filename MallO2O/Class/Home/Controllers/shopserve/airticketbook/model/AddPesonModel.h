//
//  AddPesonModel.h
//  MallO2O
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddPesonModel : NSObject

/**
 *  姓名
 */
@property (copy ,nonatomic) NSString *name;
/**
 *  护照号码
 */
@property (copy ,nonatomic) NSString *passport;

@property (copy ,nonatomic) NSString *nationality;

@property (copy ,nonatomic) NSString *nationality_id;
// 乘客类型
@property (copy ,nonatomic) NSString *type;
@property (copy ,nonatomic) NSString *p_id;
@property (assign ,nonatomic) BOOL typ;

+ (instancetype)init:(NSDictionary *)dic;

@end
