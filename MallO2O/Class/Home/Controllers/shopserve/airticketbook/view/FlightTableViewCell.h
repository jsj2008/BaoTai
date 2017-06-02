//
//  FlightTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/10.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightTableViewCell : UITableViewCell

+ (instancetype)flightCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellID:(NSString *)cellID;

@end
