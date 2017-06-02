//
//  InvitationImageModel.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/15.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvitationImageModel : NSObject
/**
 *  图片数组
 */
@property (strong ,nonatomic) NSMutableArray *imageArray;
/**
 *  图片类型名称
 */
@property (copy ,nonatomic) NSString       *imageTypeString;

@end
