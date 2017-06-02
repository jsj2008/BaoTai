//
//  DestineTableViewCell.m
//  MallO2O
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "DestineTableViewCell.h"


@interface DestineTableViewCell ()

/**箭头图标*/
@property (strong ,nonatomic) UIImageView *arrowsImageView;

// 起始位置
@property (strong ,nonatomic) UILabel *startPlaceLabel;
// 到达位置
@property (strong ,nonatomic) UILabel *arrivedPlaceLabel;
// 左侧出发时间
@property (strong ,nonatomic) UILabel *leftTimeLabel;
// 右侧出发时间
@property (strong ,nonatomic) UILabel *rightTimeLabel;
// 显示是否支付
@property (strong ,nonatomic) UILabel *payLabel;

@end

@implementation DestineTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        [self setAutoLayout];
    }
    return self;
}

+ (instancetype)destineCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellID:(NSString *)cellID{
    DestineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  添加UI
 */
- (void)addUI{
    [self.contentView addSubview:self.startPlaceLabel];
    [self.contentView addSubview:self.arrowsImageView];
    [self.contentView addSubview:self.arrivedPlaceLabel];
    [self.contentView addSubview:self.leftTimeLabel];
    [self.contentView addSubview:self.rightTimeLabel];
    [self.contentView addSubview:self.payLabel];
}
/**
 *  设置自动布局
 */
- (void)setAutoLayout{
    [self.startPlaceLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.startPlaceLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [self.startPlaceLabel autoSetDimension:ALDimensionHeight toSize:23*Balance_Heith];
    [self.startPlaceLabel autoSetDimension:ALDimensionWidth toSize:60];
    
    
    [self.arrowsImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.startPlaceLabel withOffset:10*Balance_Width];
    [self.arrowsImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30 * Balance_Heith];
    [self.arrowsImageView autoSetDimension:ALDimensionWidth toSize:60*Balance_Width];
    [self.arrowsImageView autoSetDimension:ALDimensionHeight toSize:10];
    
    
    [self.arrivedPlaceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.startPlaceLabel withOffset:80*Balance_Width];
    [self.arrivedPlaceLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [self.arrivedPlaceLabel autoSetDimension:ALDimensionWidth toSize:60];
    [self.arrivedPlaceLabel autoSetDimension:ALDimensionHeight toSize:23*Balance_Heith];
    
    
    [self.leftTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.leftTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.startPlaceLabel withOffset:-3];
    [self.leftTimeLabel autoSetDimension:ALDimensionHeight toSize:23*Balance_Heith];
    [self.leftTimeLabel autoSetDimension:ALDimensionWidth toSize:80];
    
    
    [self.rightTimeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.startPlaceLabel withOffset:80 * Balance_Width];
    [self.rightTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.startPlaceLabel withOffset:-3];
    [self.rightTimeLabel autoSetDimension:ALDimensionWidth toSize:80];
    [self.rightTimeLabel autoSetDimension:ALDimensionHeight toSize:23 * Balance_Heith];
    
    
    [self.payLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.payLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [self.payLabel autoSetDimension:ALDimensionHeight toSize:45*Balance_Heith];
    [self.payLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.arrivedPlaceLabel withOffset:10];
}

- (void)setModel:(DestineModel *)model {
    _model = model;
    _startPlaceLabel.text = model.origin;
    _arrivedPlaceLabel.text = model.destination;
    _leftTimeLabel.text = model.out_time;
    _rightTimeLabel.text = model.back_time;
    if ([model.type intValue] == 1) {
        
        _rightTimeLabel.text = @"";
        _arrowsImageView.image = [UIImage imageNamed:@"dc"];
    }
    else {
        _rightTimeLabel.text = model.back_time;
        _arrowsImageView.image = [UIImage imageNamed:@"wf"];
    }
    
    if ([model.is_pay integerValue] == 0) {
        
        _payLabel.text = NSLocalizedString(@"payNO", nil);
    }
    if ([model.is_pay integerValue] == 1) {
        
        _payLabel.text = NSLocalizedString(@"payOK", nil);;
    }
}

#pragma mark - 控件的初始化
- (UILabel *)startPlaceLabel{
    if (!_startPlaceLabel) {
        _startPlaceLabel = [[UILabel alloc] initForAutoLayout];
        _startPlaceLabel.textAlignment = NSTextAlignmentLeft;
        
        _startPlaceLabel.textColor = UIColorFromRGB(0x565656);
        _startPlaceLabel.font = [UIFont systemFontOfSize:18];
    }
    return _startPlaceLabel;
}

- (UIImageView *)arrowsImageView{
    if (!_arrowsImageView) {
        _arrowsImageView = [[UIImageView alloc] initForAutoLayout];
//        _arrowsImageView.backgroundColor = [UIColor blackColor];
        
    }
    return _arrowsImageView;
}

- (UILabel *)arrivedPlaceLabel{
    if (!_arrivedPlaceLabel) {
        _arrivedPlaceLabel = [[UILabel alloc] initForAutoLayout];
        _arrivedPlaceLabel.font = [UIFont systemFontOfSize:18];
        
        _arrivedPlaceLabel.textColor = UIColorFromRGB(0x565656);
        _arrivedPlaceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _arrivedPlaceLabel;
}

- (UILabel *)leftTimeLabel{
    if (!_leftTimeLabel) {
        _leftTimeLabel = [[UILabel alloc] initForAutoLayout];
        _leftTimeLabel.textColor = UIColorFromRGB(0x787878);
        
        _leftTimeLabel.numberOfLines = 0;
        _leftTimeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _leftTimeLabel;
}

- (UILabel *)rightTimeLabel{
    if (!_rightTimeLabel) {
        _rightTimeLabel = [[UILabel alloc] initForAutoLayout];
        _rightTimeLabel.textColor = UIColorFromRGB(0x787878);
        
        _rightTimeLabel.numberOfLines = 0;
        _rightTimeLabel.textAlignment = NSTextAlignmentLeft;
        _rightTimeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightTimeLabel;
}

- (UILabel *)payLabel{
    if (!_payLabel) {
        _payLabel = [[UILabel alloc] initForAutoLayout];
        _payLabel.textColor = UIColorFromRGB(0x1a9ded);
        _payLabel.font = [UIFont systemFontOfSize:17];
        
        _payLabel.textAlignment = NSTextAlignmentRight;
        _payLabel.numberOfLines = 0;
    }
    return _payLabel;
}

@end
