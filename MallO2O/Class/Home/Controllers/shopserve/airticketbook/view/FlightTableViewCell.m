//
//  FlightTableViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/10.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "FlightTableViewCell.h"

@interface FlightTableViewCell ()
/**出发时间*/
@property (strong ,nonatomic) UILabel *startTimeLabel;
/**到达时间*/
@property (strong ,nonatomic) UILabel *arrivedTimeLabel;
/**起始位置*/
@property (strong ,nonatomic) UILabel *startPlaceLabel;
/**到达位置*/
@property (strong ,nonatomic) UILabel *arrivedPlaceLabel;
/**机场信息*/
@property (strong ,nonatomic) UILabel *airportLabel;
/**机票金额*/
@property (strong ,nonatomic) UILabel *moneyLabel;
/**箭头图标*/
@property (strong ,nonatomic) UIImageView *arrowsImageView;

@end

@implementation FlightTableViewCell

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

+ (instancetype)flightCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellID:(NSString *)cellID{
    FlightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  添加UI
 */
- (void)addUI{
    [self.contentView addSubview:self.startTimeLabel];
    [self.contentView addSubview:self.arrowsImageView];
    [self.contentView addSubview:self.arrivedTimeLabel];
    [self.contentView addSubview:self.startPlaceLabel];
    [self.contentView addSubview:self.arrivedPlaceLabel];
    [self.contentView addSubview:self.airportLabel];
    [self.contentView addSubview:self.moneyLabel];
}
/**
 *  设置自动布局
 */
- (void)setAutoLayout{
    [self.startTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.startTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6];
    [self.startTimeLabel autoSetDimension:ALDimensionHeight toSize:23*Balance_Heith];
    [self.startTimeLabel autoSetDimension:ALDimensionWidth toSize:60];
    
    
    [self.arrowsImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.startTimeLabel withOffset:10*Balance_Width];
    [self.arrowsImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20 * Balance_Heith];
    [self.arrowsImageView autoSetDimension:ALDimensionWidth toSize:60*Balance_Width];
    [self.arrowsImageView autoSetDimension:ALDimensionHeight toSize:7];
    
    
    [self.arrivedTimeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.startTimeLabel withOffset:80*Balance_Width];
    [self.arrivedTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6];
    [self.arrivedTimeLabel autoSetDimension:ALDimensionWidth toSize:60];
    [self.arrivedTimeLabel autoSetDimension:ALDimensionHeight toSize:23*Balance_Heith];
    
    
    [self.startPlaceLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.startPlaceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.startTimeLabel withOffset:-3];
    [self.startPlaceLabel autoSetDimension:ALDimensionHeight toSize:23*Balance_Heith];
    [self.startPlaceLabel autoSetDimension:ALDimensionWidth toSize:60];
    
    
    [self.arrivedPlaceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.startTimeLabel withOffset:80 * Balance_Width];
    [self.arrivedPlaceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.startTimeLabel withOffset:-3];
    [self.arrivedPlaceLabel autoSetDimension:ALDimensionWidth toSize:60];
    [self.arrivedPlaceLabel autoSetDimension:ALDimensionHeight toSize:23 * Balance_Heith];
    
    
    [self.airportLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.airportLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:2];
    [self.airportLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.airportLabel autoSetDimension:ALDimensionHeight toSize:25 * Balance_Heith];
    
    
    [self.moneyLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.moneyLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [self.moneyLabel autoSetDimension:ALDimensionHeight toSize:45*Balance_Heith];
    [self.moneyLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.arrivedPlaceLabel withOffset:10];
}

#pragma mark - 控件的初始化
- (UILabel *)startTimeLabel{
    if (!_startTimeLabel) {
        _startTimeLabel = [[UILabel alloc] initForAutoLayout];
        _startTimeLabel.textAlignment = NSTextAlignmentLeft;
        _startTimeLabel.text = @"99:99";
        _startTimeLabel.textColor = UIColorFromRGB(0x565656);
        _startTimeLabel.font = [UIFont systemFontOfSize:18];
    }
    return _startTimeLabel;
}

- (UIImageView *)arrowsImageView{
    if (!_arrowsImageView) {
        _arrowsImageView = [[UIImageView alloc] initForAutoLayout];
        _arrowsImageView.image = [UIImage imageNamed:@"arrows_right"];
    }
    return _arrowsImageView;
}

- (UILabel *)arrivedTimeLabel{
    if (!_arrivedTimeLabel) {
        _arrivedTimeLabel = [[UILabel alloc] initForAutoLayout];
        _arrivedTimeLabel.font = [UIFont systemFontOfSize:18];
        _arrivedTimeLabel.text = @"99:99";
        _arrivedTimeLabel.textColor = UIColorFromRGB(0x565656);
        _arrivedTimeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _arrivedTimeLabel;
}

- (UILabel *)startPlaceLabel{
    if (!_startPlaceLabel) {
        _startPlaceLabel = [[UILabel alloc] initForAutoLayout];
        _startPlaceLabel.textColor = UIColorFromRGB(0x787878);
        _startPlaceLabel.text = @"太平机场";
        _startPlaceLabel.numberOfLines = 0;
        _startPlaceLabel.font = [UIFont systemFontOfSize:13];
    }
    return _startPlaceLabel;
}

- (UILabel *)arrivedPlaceLabel{
    if (!_arrivedPlaceLabel) {
        _arrivedPlaceLabel = [[UILabel alloc] initForAutoLayout];
        _arrivedPlaceLabel.textColor = UIColorFromRGB(0x787878);
        _arrivedPlaceLabel.text = @"首都机场";
        _arrivedPlaceLabel.numberOfLines = 0;
        _arrivedPlaceLabel.textAlignment = NSTextAlignmentRight;
        _arrivedPlaceLabel.font = [UIFont systemFontOfSize:13];
    }
    return _arrivedPlaceLabel;
}

- (UILabel *)airportLabel{
    if (!_airportLabel) {
        _airportLabel = [[UILabel alloc] initForAutoLayout];
        _airportLabel.font = [UIFont systemFontOfSize:13];
        _airportLabel.textColor = UIColorFromRGB(0x787878);
        _airportLabel.text = @"南航公司";
    }
    return _airportLabel;
}

- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initForAutoLayout];
        _moneyLabel.textColor = UIColorFromRGB(0x1a9ded);
        _moneyLabel.font = [UIFont systemFontOfSize:17];
        _moneyLabel.text = [NSString stringWithFormat:@"%@123", NSLocalizedString(@"Money", nil)];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.numberOfLines = 0;
    }
    return _moneyLabel;
}

@end
