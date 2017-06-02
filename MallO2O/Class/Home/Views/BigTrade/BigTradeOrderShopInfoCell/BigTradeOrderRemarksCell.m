//
//  BigTradeOrderRemarksCell.m
//  MallO2O
//
//  Created by songweiping on 16/3/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeOrderRemarksCell.h"

#import "SwpTextView.h"
#import <Masonry/Masonry.h>
#import "SwpWeakifyHeader.h"
#import "BigTradeOrderRemarksModel.h"

@interface BigTradeOrderRemarksCell ()

@property (nonatomic, strong) SwpTextView *swpTextView;


@end

@implementation BigTradeOrderRemarksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)bigTradeOrderRemarksCellTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)identifier {
    
    BigTradeOrderRemarksCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpUI];
        [self settingUIAutoLayout];
        
    }
    
    return self;
}


/*!
 *  @author swp_song
 *
 *  @brief  setupUI ( 添加控件 | 设置控件自动布局 )
 */
- (void) setUpUI {
    [self.contentView addSubview:self.swpTextView];
}

/*!
 *  @author swp_song
 *
 *  @brief  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
    @swpWeakify(self);
    [self.swpTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        @swpStrongify(self);
        make.edges.equalTo(self.contentView);
        
    }];
}

- (void)setBigTradeOrderRemarks:(BigTradeOrderRemarksModel *)bigTradeOrderRemarks {
    _bigTradeOrderRemarks = bigTradeOrderRemarks;
    self.swpTextView.swpTextViewPlaceholder = _bigTradeOrderRemarks.bigTradeOrderRemarksPlaceholder;
}

- (void)bigTradeOrderRemarksCellChangeText:(void(^)(NSString * changeText))text {
    [self.swpTextView swpTextViewChangeText:^(SwpTextView * _Nonnull swpTextView, NSString * _Nonnull changeText) {
        text(changeText);
    }];
}


- (SwpTextView *)swpTextView {
    
    return !_swpTextView ? _swpTextView  = ({
        SwpTextView *swpTextView = [SwpTextView new];
    
        swpTextView;
    }) : _swpTextView;
}

@end
