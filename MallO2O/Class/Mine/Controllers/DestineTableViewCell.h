//
//  DestineTableViewCell.h
//  MallO2O
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestineModel.h"
@interface DestineTableViewCell : UITableViewCell

@property (strong ,nonatomic) DestineModel *model;


+ (instancetype)destineCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellID:(NSString *)cellID;


@end
