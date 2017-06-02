//
//  InvitationImageTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/15.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InvitationImageTableViewCellBlock)(NSIndexPath *indexPath);

typedef void(^InvitationImageTableViewCellClickAddBlock)(BOOL canClick ,NSIndexPath *cellIndexPath);

@class InvitationImageModel;

@interface InvitationImageTableViewCell : UITableViewCell

+ (instancetype)invitationImageCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellIdentfier:(NSString *)cellID;

@property (copy ,nonatomic) InvitationImageTableViewCellBlock block;

@property (copy ,nonatomic) InvitationImageTableViewCellClickAddBlock clickAddBlock;

@property (copy ,nonatomic) InvitationImageModel *imageModel;

- (void)clickDeleteButton:(InvitationImageTableViewCellBlock)block;

- (void)clickAddButtonBlock:(InvitationImageTableViewCellClickAddBlock)block;

@end
