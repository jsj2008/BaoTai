//
//  BigTradeOrderAddressCell.m
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeOrderAddressCell.h"

#import "BigTradeOrderAddressModel.h"


@interface BigTradeOrderAddressCell ()

@property (nonatomic, weak) IBOutlet UILabel *bigTradeOrderAddressTitleView;
@property (nonatomic, weak) IBOutlet UILabel *bigTradeOrderAddressSubTitleView;


@end

@implementation BigTradeOrderAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)bigTradeOrderAddressCellTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)identifier {
    
    BigTradeOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle            = UITableViewCellSelectionStyleNone;
    cell.accessoryType             = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BigTradeOrderAddressCell class]) owner:nil options:nil].lastObject;
        
    }
    return self;
}

- (void)setBigTradeOrderAddress:(BigTradeOrderAddressModel *)bigTradeOrderAddress {
    _bigTradeOrderAddress = bigTradeOrderAddress;
    [self settingData:bigTradeOrderAddress];
}


- (void)settingData:(BigTradeOrderAddressModel *)bigTradeOrderAddress {
    
    _bigTradeOrderAddressTitleView.text    = bigTradeOrderAddress.bigTradeOrderAddressTitle;
    _bigTradeOrderAddressSubTitleView.text = bigTradeOrderAddress.bigTradeOrderAddressSubTitle;
}

@end
