//
//  BigTradeCell.m
//  MallO2O
//
//  Created by songweiping on 16/3/21.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeCell.h"


#import <Masonry/Masonry.h>
#import "SwpWeakifyHeader.h"
#import "UIColor+SwpColor.h"

#import "BigTradeModel.h"

@interface BigTradeCell ()

@property (nonatomic, strong) UIImageView  *bigTradeImageView;
@property (nonatomic, strong) UILabel      *bigTradeDescribeView;
@property (nonatomic, strong) UILabel      *bigTradePriceView;

@end

@implementation BigTradeCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
        [self settingUIAutoLayout];
        
        
    }
    return self;
}

/*!
 *  @author swp_song
 *
 *  @brief  setUpUI ( 添加控件 | 设置控件自动布局 )
 */
- (void) setUpUI {
    [self.contentView addSubview:self.bigTradeImageView];
    [self.contentView addSubview:self.bigTradeDescribeView];
    [self.contentView addSubview:self.bigTradePriceView];
}

/*!
 *  @author swp_song
 *
 *  @brief  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
    @swpWeakify(self);
    [self.bigTradeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @swpStrongify(self);
        make.top.left.right.equalTo(self.contentView);
        make.width.equalTo(self.bigTradeImageView.mas_height).multipliedBy(1.0 / 1.0);
    }];
    
    
    [self.bigTradePriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @swpStrongify(self);
        make.left.equalTo(@5);
        make.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.bigTradeDescribeView.mas_bottom);
        make.height.equalTo(@25);
    }];
    
    [self.bigTradeDescribeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @swpStrongify(self);
        make.left.right.equalTo(self.bigTradePriceView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.bigTradeImageView.mas_bottom);
        make.bottom.equalTo(self.bigTradePriceView.mas_top);
    }];
    
}

- (void)setBigTrade:(BigTradeModel *)bigTrade {
    
    _bigTrade = bigTrade;
    [self settingData:_bigTrade];
}

- (void)settingData:(BigTradeModel *)bigTrade {
    
    [self.bigTradeImageView sd_setImageWithURL:[NSURL URLWithString:bigTrade.bigTradeImageURL] placeholderImage:nil];
    self.bigTradeDescribeView.text = bigTrade.bigTradeName;
    self.bigTradePriceView.text    = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Money", nil), bigTrade.bigTradePrice];
}

- (UIImageView *)bigTradeImageView {
    
    return !_bigTradeImageView ? _bigTradeImageView = ({
        UIImageView *imageView = [UIImageView new];
        imageView;
    }) : _bigTradeImageView;
}

- (UILabel *)bigTradeDescribeView {
    
    return !_bigTradeDescribeView ? _bigTradeDescribeView = ({
        UILabel *label = [UILabel new];
        label.numberOfLines = 2;
        label.text          = @"中恒鹰眼119电子狗中的 Mini Cooper";
        label.font          = [UIFont systemFontOfSize:13];
        label.textColor     = [UIColor swpColorFromHEX:0x484848];
        label;
    }) : _bigTradeDescribeView;
    
}

- (UILabel *)bigTradePriceView {
    
    return !_bigTradePriceView ? _bigTradePriceView = ({
        UILabel *label  = [UILabel new];
        label.text      = [NSString stringWithFormat:@"%@ 210", NSLocalizedString(@"Money", nil)];
        label.font      = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor swpColorFromHEX:0x2bb6f5];
        label;
    }) : _bigTradePriceView;
}


@end
