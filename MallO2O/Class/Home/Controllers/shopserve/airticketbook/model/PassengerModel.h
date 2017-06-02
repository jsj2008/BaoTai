//
//  PassengerModel.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/11.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassengerModel : NSObject
/**
 *  类型
 */
@property (copy ,nonatomic) NSString *typeString;
/**
 *  placeholder
 */
@property (copy ,nonatomic) NSString *placeholderString;
/**
 *  详细的信息
 */
@property (copy ,nonatomic) NSString *detailString;
/**
 *  cell的类型
 */
@property (nonatomic ) UITableViewCellAccessoryType cellAccessoryType;
/**
 *  跳转的页面
 */
@property (copy ,nonatomic) NSString *viewControllerName;
/**
 *  输入框是否可编辑
 */
@property (nonatomic) BOOL textFieldCanEdit;
/**
 *  一些数据的id参数
 */
@property (copy ,nonatomic) NSString *dataID;
/**
 *  上传的key
 */
@property (copy ,nonatomic) NSString *key;

@property (copy ,nonatomic) NSString *p_id;

// 乘客类型
@property (copy ,nonatomic) NSString *passengerType;



/**
 *  初始化模型添加数据
 *
 *  @param typeString        数据类型
 *  @param detailString      输入的文字
 *  @param palceHolder       placeholder
 *  @param cellAccessoryType cell的类型
 *  @param vcName            跳转的控制器名称
 *
 *  @return 
 */
+ (instancetype) setPassengerModel:(NSString *)typeString p_id:(NSString *)p_id passengerType:(NSString *)passengerType detailString:(NSString *)detailString placeHolder:(NSString *)palceHolder cellAccessoryType:(UITableViewCellAccessoryType)cellAccessoryType pushViewControllerName:(NSString *)vcName;

@end
