//
//  WebModel.h
//  MallO2O
//
//  Created by mac on 16/6/2.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebModel : NSObject
// 联系人
@property (copy ,nonatomic) NSString *consignee_name;
// 接收凭证人联系电话
@property (copy ,nonatomic) NSString *consignee_tel;
// 接收凭证地址
@property (copy ,nonatomic) NSString *consignee_address;



// 火车出境强制险
@property (copy ,nonatomic) NSString *train_compulsory_insurance;
// 火车意外险
@property (copy ,nonatomic) NSString *train_accident_insurance;

// 飞机延误险
@property (copy ,nonatomic) NSString *plane_delay;
// 飞机意外险
@property (copy ,nonatomic) NSString *plane_accident_insurance;

// 姓名
@property (copy ,nonatomic) NSString *name;
// 联系电话
@property (copy ,nonatomic) NSString *tel;


// 报销凭证
@property (copy ,nonatomic) NSString *voucher;

@end
