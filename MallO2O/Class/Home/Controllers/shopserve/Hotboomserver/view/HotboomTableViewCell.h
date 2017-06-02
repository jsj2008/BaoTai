//
//  HotboomTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/15.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "SuperTableViewCell.h"

@class HotboomModel;

@interface HotboomTableViewCell : SuperTableViewCell

@property (copy ,nonatomic) HotboomModel *model;

+ (instancetype)hotboomCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellID:(NSString *)cellid;

@end
