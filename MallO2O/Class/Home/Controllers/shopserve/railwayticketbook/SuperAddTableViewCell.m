//
//  SuperAddTableViewCell.m
//  MallO2O
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "SuperAddTableViewCell.h"
#import "PassengerModel.h"

@interface SuperAddTableViewCell ()

@property (strong ,nonatomic) UILabel *typeLabel;


@end

@implementation SuperAddTableViewCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+ (instancetype)superCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellIdentifier:(NSString *)cellID{
    SuperAddTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)addUI{
    [self.contentView addSubview:self.typeLabel];
    
    
}

- (void)setAutoLayout{
    [self.typeLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 15, 5, 0)excludingEdge:ALEdgeRight];
    [self.typeLabel autoSetDimension:ALDimensionWidth toSize:100];
    
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] initForAutoLayout];
        //        _typeLabel.layer.borderWidth = 1;
        _typeLabel.textColor = UIColorFromRGB(0x454545);
        _typeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _typeLabel;
}


- (void)setSuperModel:(PassengerModel *)superModel{
    _superModel = superModel;
    self.typeLabel.text = superModel.typeString;
}

- (void)setTypeName:(NSString *)typeName{
    self.typeLabel.text = typeName;
}


@end
