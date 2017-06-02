//
//  SuperTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/11.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PassengerModel;

@interface SuperTableViewCell : UITableViewCell

+ (instancetype)superCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellIdentifier:(NSString *)cellID;
/**
 *  这是父类model（就是乘机人选择国籍和生日的）
 */
@property (copy ,nonatomic) PassengerModel *superModel;


@property (copy ,nonatomic) NSString *typeName;




@end
