//
//  GzyCommenMetthod.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GzyCommenMetthod : NSObject
/**
 *  设置actionsheet的方法（仅用于actionsheet）
 *
 *  @param title            actionsheet标题
 *  @param message          actionsheet内容
 *  @param view             添加的视图（不填为nil）
 *  @param viewController   所在控制器
 *  @param buttonArray      添加其他按钮的数组
 *  @param delegate         委托（ios8以下使用）
 *  @param okBlock          点击确认的block
 *  @param cancleBlock      点击取消的block
 *  @param otherActionBlock 点击其他按钮的block（ios7通过外部委托判断索引）
 */
+ (void)setActionSheetTitle:(NSString *)title andMeesage:(NSString *)message addView:(UIView *)view inViewController:(UIViewController *)viewController buttonArray:(NSArray <NSString *>*)buttonArray andActionSheetTag:(NSInteger)tag delegate:(id)delegate andComplete:(void (^) (UIAlertAction *action))okBlock andCancleAction:(void (^)(UIAlertAction *action))cancleBlock andOtherAction:(void (^)(UIAlertAction *action))otherActionBlock okButtonIsNil:(BOOL)isNil;
/**
 *  检测是否为邮箱格式
 *
 *  @param email 输入字符
 *
 *  @return 
 */
+ (BOOL)checkEmail:(NSString *)email;

/**
 *  判断手机输入的正则表达式
 *
 *  @param tel 输入文字
 *
 *  @return
 */
+ (BOOL)checkTel:(NSString *)tel;

/**
 *  判断数字输入的正则表达式
 *
 *  @param tel 输入文字
 *
 *  @return
 */
+ (BOOL)checkInt:(NSString *)inputText;

@end
