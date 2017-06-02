//
//  InternationalCityViewController.h
//  MallO2O
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

typedef void(^InternationalCityBlock)(NSString *cityName,NSString *cityID);

@interface InternationalCityViewController : MallO2OBaseViewController

@property (copy ,nonatomic) InternationalCityBlock internationalCityBlock;

- (void)getCityNameAndCityID:(InternationalCityBlock )block;

@end
