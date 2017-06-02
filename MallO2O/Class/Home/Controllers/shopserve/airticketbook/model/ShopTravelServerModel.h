//
//  ShopTravelServerModel.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/14.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopTravelServerModel : NSObject

@property (copy ,nonatomic) NSString *viewControllerName;

@property (copy ,nonatomic) NSString *imageName;

@property (copy ,nonatomic) NSString *serverName;

@property (copy ,nonatomic) NSString *serverID;

+ (ShopTravelServerModel *)setModelVCName:(NSString *)viewControllerName andImageName:(NSString *)imageName andServerName:(NSString *)serverName;


@end
