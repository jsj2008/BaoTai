//
//  ChoosePassengerViewController.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/11.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

typedef void(^Block_p)(NSArray *array);

@interface ChoosePassengerViewController : MallO2OBaseViewController

@property (copy ,nonatomic) NSString *chooseBody;

@property (copy ,nonatomic) Block_p popBlock;

//@property (assign ,nonatomic) BOOL isOK;

//@property (copy ,nonatomic) NSMutableArray *arry;

- (void)popViewControllerArray:(Block_p)block;

@end
