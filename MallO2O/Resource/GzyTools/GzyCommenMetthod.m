//
//  GzyCommenMetthod.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "GzyCommenMetthod.h"

@implementation GzyCommenMetthod

+ (void)setActionSheetTitle:(NSString *)title andMeesage:(NSString *)message addView:(UIView *)view inViewController:(UIViewController *)viewController buttonArray:(NSArray <NSString *>*)buttonArray andActionSheetTag:(NSInteger)tag delegate:(id)delegate andComplete:(void (^) (UIAlertAction *action))okBlock andCancleAction:(void (^)(UIAlertAction *action))cancleBlock andOtherAction:(void (^)(UIAlertAction *action))otherActionBlock okButtonIsNil:(BOOL)isNil{
//    __weak typeof(viewController) vc = viewController;
    if (IOS8) {
        UIAlertController *allertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        if (view != nil) {
            [allertController.view addSubview:view];
        }
        if (!isNil) {
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                if (okBlock) {
                    okBlock(action);
                }
            }];
            [allertController addAction:alertAction];
        }
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancleBlock) {
                cancleBlock(action);
            }
        }];
        for (int i = 0; i < buttonArray.count; i ++) {
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:buttonArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (otherActionBlock) {
                    otherActionBlock(action);
                }
            }];
            [allertController addAction:alertAction];
        }
        
        [allertController addAction:cancleAction];
        [viewController presentViewController:allertController animated:YES completion:^{
            
        }];
    }else{
        NSString *newTitle;
        if (message != nil && title != nil) {
           newTitle = [title stringByAppendingString:message];
        }
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:newTitle delegate:delegate cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//        actionSheet.
        actionSheet.tag = tag;
        
        for (int i = 0; i < buttonArray.count; i ++) {
            [actionSheet addButtonWithTitle:buttonArray[i]];
        }
        
        if (!isNil) {
            [actionSheet addButtonWithTitle:NSLocalizedString(@"OK", nil)];
        }
        
        [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
        if (!isNil) {
            actionSheet.destructiveButtonIndex = actionSheet.numberOfButtons - 2;
        }
        //取消按钮也是这会再加
        actionSheet.cancelButtonIndex = actionSheet.numberOfButtons -1;
        
        if (view != nil) {
            [actionSheet addSubview:view];
        }
        [actionSheet showInView:viewController.view];
    }
    
}

/**
 *  检测是否为邮箱
 *
 *  @param email 输入文字
 */
+ (BOOL)checkEmail:(NSString *)email{
    NSString    *mailboxesAre = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate    = [NSPredicate predicateWithFormat:@"self matches %@", mailboxesAre];
    if (![predicate evaluateWithObject:email]) {
        return NO;
    }
    return YES;
}
/**
 *  判断手机输入的正则表达式
 *
 *  @param tel 输入文字
 *
 *  @return
 */
+ (BOOL)checkTel:(NSString *)tel{
    NSString    *mailboxesAre = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *predicate    = [NSPredicate predicateWithFormat:@"self matches %@", mailboxesAre];
    if (![predicate evaluateWithObject:tel]) {
        return NO;
    }
    return YES;
}

+ (BOOL)checkInt:(NSString *)inputText{
    NSString    *mailboxesAre = @"^[0-9]*$";
    NSPredicate *predicate    = [NSPredicate predicateWithFormat:@"self matches %@", mailboxesAre];
    if (![predicate evaluateWithObject:inputText]) {
        return NO;
    }
    return YES;
}

@end
