//
//  InvitationImageTableViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/15.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "InvitationImageTableViewCell.h"

#import "SwpSelectPhotographView.h"

#import "InvitationImageModel.h"

@interface InvitationImageTableViewCell ()

@property (strong ,nonatomic) SwpSelectPhotographView *selectPhotoView;

@property (strong ,nonatomic) UILabel *imageTitleLabel;

@property (copy   ,nonatomic) NSIndexPath *selectIndexPath;

@end

@implementation InvitationImageTableViewCell

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
        [self getImageCollectionBlock];
    }
    return self;
}

+ (instancetype)invitationImageCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellIdentfier:(NSString *)cellID{
    InvitationImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectIndexPath = indexPath;
    return cell;
}

- (void)addUI{
    [self.contentView addSubview:self.selectPhotoView];
    [self.contentView addSubview:self.imageTitleLabel];
}

- (void)setAutoLayout{
    [self.imageTitleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) excludingEdge:ALEdgeBottom];
    [self.imageTitleLabel autoSetDimension:ALDimensionHeight toSize:35];
}

- (void)clickDeleteButton:(InvitationImageTableViewCellBlock)block{
    self.block = block;
}

- (void)clickAddButtonBlock:(InvitationImageTableViewCellClickAddBlock)block{
    self.clickAddBlock = block;
}

- (void)getImageCollectionBlock{
    __weak typeof(InvitationImageTableViewCell *) view = self;
    [_selectPhotoView swpSelectPhotographViewClickDeleteButton:^(SwpSelectPhotographView * _Nonnull swpSelectPhotographView, NSIndexPath * _Nonnull indexPath) {
        if (view.block) {
            view.block(indexPath);
        }
    }];
    [_selectPhotoView swpSelectPhotographViewClickAddImage:^(SwpSelectPhotographView * _Nonnull swpSelectPhotographView, BOOL isPermitAdd) {
        if (view.clickAddBlock) {
            view.clickAddBlock(isPermitAdd,view.selectIndexPath);
        }
    }];
}

- (void)setImageModel:(InvitationImageModel *)imageModel{
    _imageTitleLabel.text = imageModel.imageTypeString;
    _selectPhotoView.swpSelectImageDataSource = imageModel.imageArray;
}

- (UILabel *)imageTitleLabel{
    if (!_imageTitleLabel) {
        _imageTitleLabel = [[UILabel alloc] initForAutoLayout];
        _imageTitleLabel.textColor = UIColorFromRGB(0x565656);
        _imageTitleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _imageTitleLabel;
}

- (SwpSelectPhotographView *)selectPhotoView{
    if (!_selectPhotoView) {
        _selectPhotoView = [[SwpSelectPhotographView alloc] initSwpSelectPhotograph];
        _selectPhotoView.frame = CGRectMake(15, 35, SCREEN_WIDTH - 30, 40);
        _selectPhotoView.swpSelectPhotograpImagMaxQuantity = 8.0f;
        _selectPhotoView.swpSelectPhotographCellDeleteButtonImage = [UIImage imageNamed:@"ff"];
    }
    return _selectPhotoView;
}



@end
