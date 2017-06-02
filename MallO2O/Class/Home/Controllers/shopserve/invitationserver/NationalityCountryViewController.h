//
//  NationalityCountryViewController.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

typedef void(^NationalVCBlock)(NSString *countryName ,NSString *countryID);

@interface NationalityCountryViewController : MallO2OBaseViewController

@property (copy ,nonatomic) NationalVCBlock nationalBlock;

- (void)getCountryNameAndCountryID:(NationalVCBlock)block;

@end
