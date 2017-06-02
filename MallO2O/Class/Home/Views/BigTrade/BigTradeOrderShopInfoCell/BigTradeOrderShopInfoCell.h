//
//  BigTradeOrderShopInfoCell.h
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BigTradeOrderShopInfoModel;

NS_ASSUME_NONNULL_BEGIN
@interface BigTradeOrderShopInfoCell : UITableViewCell

+ (instancetype)bigTradeOrderShopInfoCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)identifier;


@property (nonatomic, strong) BigTradeOrderShopInfoModel *bigTradeOrderShopInfo;


@end

NS_ASSUME_NONNULL_END
