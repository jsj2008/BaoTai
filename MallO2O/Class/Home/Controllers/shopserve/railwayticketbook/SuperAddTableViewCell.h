//
//  SuperAddTableViewCell.h
//  MallO2O
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PassengerModel;

@interface SuperAddTableViewCell : UITableViewCell

+ (instancetype)superCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellIdentifier:(NSString *)cellID;
/**
 *  这是父类model（就是乘机人选择国籍和生日的）
 */
@property (copy ,nonatomic) PassengerModel *superModel;


@property (copy ,nonatomic) NSString *typeName;


@end
