//
//  BigTradeOrderRemarksCell.h
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BigTradeOrderRemarksModel;

NS_ASSUME_NONNULL_BEGIN
@interface BigTradeOrderRemarksCell : UITableViewCell

+ (instancetype)bigTradeOrderRemarksCellTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)identifier;

@property (nonatomic, strong) BigTradeOrderRemarksModel *bigTradeOrderRemarks;

- (void)bigTradeOrderRemarksCellChangeText:(void(^)(NSString * changeText))text;

@end

NS_ASSUME_NONNULL_END
