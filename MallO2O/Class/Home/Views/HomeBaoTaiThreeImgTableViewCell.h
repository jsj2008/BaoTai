//
//  HomeBaoTaiThreeImgTableViewCell.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/15.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HomeBaoTaiThreeImgTableViewCellBlock)(NSInteger imageIndex);

@interface HomeBaoTaiThreeImgTableViewCell : UITableViewCell

@property (copy ,nonatomic) HomeBaoTaiThreeImgTableViewCellBlock block;
+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellIdentifier:(NSString *)cellID;

- (void)clickImageBlock:(HomeBaoTaiThreeImgTableViewCellBlock)block;

@end
