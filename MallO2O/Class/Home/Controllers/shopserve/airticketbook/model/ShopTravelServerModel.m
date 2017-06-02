//
//  ShopTravelServerModel.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/14.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "ShopTravelServerModel.h"

@implementation ShopTravelServerModel

+ (ShopTravelServerModel *)setModelVCName:(NSString *)viewControllerName andImageName:(NSString *)imageName andServerName:(NSString *)serverName{
    ShopTravelServerModel *model = [[ShopTravelServerModel alloc] init];
    model.viewControllerName = viewControllerName;
    model.imageName = imageName;
    model.serverName = serverName;
    return model;
}

@end
