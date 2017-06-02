//
//  ChoosePassengerTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/11.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPesonModel.h"

typedef void(^BlockButton)();

@interface ChoosePassengerTableViewCell : UITableViewCell

@property (strong ,nonatomic) AddPesonModel *dataList;

@property (strong ,nonatomic) UIButton *choosButton;

@property (strong ,nonatomic) UIButton *editButton;

@property (nonatomic ,copy) BlockButton button;


+ (instancetype)choosePassengerCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellIdentifier:(NSString *)identifier;

//- (void)setCellSelected:(BOOL)selectedType;

- (void)getButtonAction:(BlockButton )button;

@end
