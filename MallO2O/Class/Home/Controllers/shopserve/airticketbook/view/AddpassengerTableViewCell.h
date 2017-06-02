//
//  AddpassengerTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/11.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "SuperTableViewCell.h"

@class PassengerModel;

typedef void(^AddpassengerTableViewCellBlock)(NSString *inputText,NSInteger index,NSInteger indexRow);

@interface AddpassengerTableViewCell : SuperTableViewCell

+ (instancetype)addPassengerCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellIdentifier:(NSString *)cellID;

/**
 *  这是添加乘机人的model
 */
@property (copy ,nonatomic) PassengerModel *addModel;
/**
 *  返回文字的block
 */
@property (strong ,nonatomic) AddpassengerTableViewCellBlock block;
/**
 *  获取此cell的block
 *
 *  @param block
 */
- (void)getAddpassengerTableViewCellBlock:(AddpassengerTableViewCellBlock)block;

@end
