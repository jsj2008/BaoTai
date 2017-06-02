//
//  EditInfoTableViewCell.h
//  MallO2O
//
//  Created by mac on 15/6/12.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerInfoModel.h"
#import "EditInfoTableViewCell.h"

@protocol EditInfoTableViewCellDelegate <NSObject>

- (void)textFieldText:(NSString *)text atIndepath:(NSIndexPath *)index;

@end

@interface EditInfoTableViewCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexpath:(NSIndexPath *)index;

@property (strong ,nonatomic) NSString *typeText;

@property (assign ,nonatomic) id<EditInfoTableViewCellDelegate>delegate;

@property (copy ,nonatomic) NSIndexPath *indexPath;

@property (strong ,nonatomic) NSString *imgUrl;

@property (strong ,nonatomic) NSString *userName;

@property (strong ,nonatomic) NSString *sexString;

@property (strong ,nonatomic) UIImageView *headImgView;

@property (copy ,nonatomic) NSString *email; //邮箱

@property (copy ,nonatomic) NSString *passport; //护照号码
@end
