//
//  SucceedViewController.h
//  MallO2O
//
//  Created by mac on 16/6/2.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface SucceedViewController : MallO2OBaseViewController


@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIButton *button;



- (IBAction)button:(UIButton *)sender;


@end
