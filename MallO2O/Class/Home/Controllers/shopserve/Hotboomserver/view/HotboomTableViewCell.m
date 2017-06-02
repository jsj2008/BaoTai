//
//  HotboomTableViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/15.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "HotboomTableViewCell.h"
#import "HotboomModel.h"

@interface HotboomTableViewCell ()

@property (strong ,nonatomic) UIImageView *exanmpleImage;

@end

@implementation HotboomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addHotBoomUI];
        [self setHotBoomAutoLayout];
    }
    return self;
}

+ (instancetype)hotboomCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellID:(NSString *)cellid{
    HotboomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)addHotBoomUI{
    [self.contentView addSubview:self.exanmpleImage];
}

- (void)setHotBoomAutoLayout{
    [self.exanmpleImage autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.exanmpleImage autoSetDimension:ALDimensionWidth toSize:40 * Balance_Width];
    [self.exanmpleImage autoSetDimension:ALDimensionHeight toSize:35 * Balance_Heith];
    [self.exanmpleImage autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
}

- (void)setModel:(HotboomModel *)model{
    self.typeName = model.typeName;
    self.exanmpleImage.image = model.hotboomImage;
}

- (UIImageView *)exanmpleImage{
    if (!_exanmpleImage) {
        _exanmpleImage = [[UIImageView alloc] initForAutoLayout];
        _exanmpleImage.layer.cornerRadius = 4;
        _exanmpleImage.layer.masksToBounds = YES;
    }
    return _exanmpleImage;
}

@end
