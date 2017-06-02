//
//  BigTradeOrderShopInfoCell.m
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeOrderShopInfoCell.h"

#import "BigTradeOrderShopInfoModel.h"

@interface BigTradeOrderShopInfoCell ()


@property (nonatomic, weak) IBOutlet UILabel *bigTradeOrderShopInfoTitleView;
@property (nonatomic, weak) IBOutlet UILabel *bigTradeOrderShopInfoSubTitleView;

@end

@implementation BigTradeOrderShopInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)bigTradeOrderShopInfoCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)identifier {
    
    
    BigTradeOrderShopInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
        
    }
    return self;
}

- (void)setBigTradeOrderShopInfo:(BigTradeOrderShopInfoModel *)bigTradeOrderShopInfo {
    _bigTradeOrderShopInfo = bigTradeOrderShopInfo;
    [self settingData:_bigTradeOrderShopInfo];

}

- (void)settingData:(BigTradeOrderShopInfoModel *)bigTradeOrderShopInfo {
    
    _bigTradeOrderShopInfoTitleView.text = bigTradeOrderShopInfo.bigTradeOrderShopInfoTitle;
    _bigTradeOrderShopInfoSubTitleView.text = bigTradeOrderShopInfo.bigTradeOrderShopInfoSubTitle;
    
}




@end
