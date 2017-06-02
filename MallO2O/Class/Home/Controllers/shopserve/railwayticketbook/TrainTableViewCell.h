//
//  TrainTableViewCell.h
//  MallO2O
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainTableViewCell : UITableViewCell

+ (instancetype)trainCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellID:(NSString *)cellID;

@end
