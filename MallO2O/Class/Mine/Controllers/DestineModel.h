//
//  DestineModel.h
//  MallO2O
//
//  Created by mac on 16/6/1.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestineModel : NSObject

@property (copy ,nonatomic) NSString *back_time;
@property (copy ,nonatomic) NSString *destination;
@property (copy ,nonatomic) NSString *origin;
@property (copy ,nonatomic) NSString *out_time;
@property (copy ,nonatomic) NSString *r_id;
@property (copy ,nonatomic) NSString *type;
@property (copy ,nonatomic) NSString *is_pay;
@property (copy ,nonatomic) NSString *url;

+ (instancetype)init:(NSMutableDictionary *)dic;



@end
