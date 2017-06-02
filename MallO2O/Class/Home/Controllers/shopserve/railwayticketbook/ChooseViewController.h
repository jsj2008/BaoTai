//
//  ChooseViewController.h
//  MallO2O
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

typedef void(^Block_pp)(NSArray *array);

@interface ChooseViewController : MallO2OBaseViewController

@property (copy ,nonatomic) Block_pp popBlock;

- (void)popViewControllerArray:(Block_pp)block;


@end
