//
//  ChooseTableViewCell.h
//  MallO2O
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPesonModel.h"

typedef void(^BlockButton)();

@interface ChooseTableViewCell : UITableViewCell

@property (strong ,nonatomic) AddPesonModel *dataList;

@property (strong ,nonatomic) UIButton *editButton;

// 选中按钮
@property (strong ,nonatomic)  UIButton *choosButton;

@property (nonatomic ,copy) BlockButton button;

+ (instancetype)chooseCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellIdentifier:(NSString *)identifier;

- (void)getButtonAction:(BlockButton )button;

@end
