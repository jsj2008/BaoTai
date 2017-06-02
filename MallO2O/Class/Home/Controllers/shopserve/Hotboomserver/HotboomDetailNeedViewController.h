//
//  HotboomDetailNeedViewController.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/22.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

typedef void(^HotboomDetalNeedBlock)(NSString *inputText);

@interface HotboomDetailNeedViewController : MallO2OBaseViewController

@property (copy ,nonatomic) HotboomDetalNeedBlock detailNeedBlock;

- (void)getDetailInfo:(HotboomDetalNeedBlock)block;

@end
