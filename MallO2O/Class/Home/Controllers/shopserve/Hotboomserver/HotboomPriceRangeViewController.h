//
//  HotboomPriceRangeViewController.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/16.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

typedef void(^HotBoomPriceRangeBlock)(NSString *lowPrice ,NSString *highPrice);

@interface HotboomPriceRangeViewController : MallO2OBaseViewController

@property (copy ,nonatomic) HotBoomPriceRangeBlock priceRangeBlock;

- (void)getPriceRange:(HotBoomPriceRangeBlock)block;

@end
