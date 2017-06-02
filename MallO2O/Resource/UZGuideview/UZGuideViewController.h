//
//  UZGuideViewController.h
//  WZGuideViewController
//
//  Created by mac on 13-12-19.
//  Copyright (c) 2013年 ZhuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageName.h"
@class UZGuideViewController;

/**
 * @brief           引导界面类
 *
 *                  首次启动APP的引导界面，根据所用的图片来确定翻页次数。
 * @author          xiaog
 * @version         0.1
 * @date            2012-12-17
 */
@interface UZGuideViewController : UIViewController

+ (UZGuideViewController *)sharedGuide;

+ (void)show;
+ (void)hide;

@end
