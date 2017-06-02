//
//  BigTradeOrderAddressCell.h
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BigTradeOrderAddressModel;

NS_ASSUME_NONNULL_BEGIN
@interface BigTradeOrderAddressCell : UITableViewCell

+ (instancetype)bigTradeOrderAddressCellTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)identifier;

@property (nonatomic, strong) BigTradeOrderAddressModel *bigTradeOrderAddress;

@end

NS_ASSUME_NONNULL_END
