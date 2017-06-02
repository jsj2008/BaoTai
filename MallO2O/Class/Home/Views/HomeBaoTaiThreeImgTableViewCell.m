//
//  HomeBaoTaiThreeImgTableViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/15.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "HomeBaoTaiThreeImgTableViewCell.h"
#import "UIColor+SwpColor.h"

@interface HomeBaoTaiThreeImgTableViewCell ()

@property (strong ,nonatomic) UIImageView *imageView1;

@property (strong ,nonatomic) UIImageView *imageView2;

@property (strong ,nonatomic) UIImageView *imageView3;

//@property (strong ,nonatomic) UIView *bottomView;

@end

@implementation HomeBaoTaiThreeImgTableViewCell

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

+ (instancetype)cellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellIdentifier:(NSString *)cellID{
    HomeBaoTaiThreeImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)addUI{
    [self.contentView addSubview:self.imageView1];
    [self.contentView addSubview:self.imageView2];
    [self.contentView addSubview:self.imageView3];
//    [self.contentView addSubview:self.bottomView];
}

- (void)setAutoLayout{
    [self.imageView1 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeRight];
    [self.imageView1 autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/3];
    
    [self.imageView2 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH/3, 0, 0) excludingEdge:ALEdgeRight];
    [self.imageView2 autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/3];
    
    [self.imageView3 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH*2/3, 0, 0) excludingEdge:ALEdgeRight];
    [self.imageView3 autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/3];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
    UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
    UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
    self.imageView1.userInteractionEnabled = YES;
    self.imageView2.userInteractionEnabled = YES;
    self.imageView3.userInteractionEnabled = YES;
    [self.imageView1 addGestureRecognizer:gesture];
    [self.imageView2 addGestureRecognizer:gesture1];
    [self.imageView3 addGestureRecognizer:gesture2];
//    [_goodsNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_goodsImage withOffset:0];
//    [self.bottomView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imageView1 withOffset:0];
//    [self.bottomView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
//    [self.bottomView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
//    [self.bottomView autoSetDimension:ALDimensionHeight toSize:2];
}

- (void)clickImage:(UITapGestureRecognizer *)gesture{
    if (self.block) {
        self.block(gesture.view.tag);
    }
}

- (void)clickImageBlock:(HomeBaoTaiThreeImgTableViewCellBlock)block{
    self.block = block;
}

- (UIImageView *)imageView1{
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] initForAutoLayout];
        _imageView1.image = [UIImage imageNamed:@"home_image_one"];
        _imageView1.tag = 1 ;
    }
    return _imageView1;
}

- (UIImageView *)imageView2{
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] initForAutoLayout];
        _imageView2.image = [UIImage imageNamed:@"home_image_two"];
        _imageView2.tag = 2;
    }
    return _imageView2;
}

- (UIImageView *)imageView3{
    if (!_imageView3) {
        _imageView3 = [[UIImageView alloc] initForAutoLayout];
        _imageView3.image = [UIImage imageNamed:@"home_image_three"];
        _imageView3.tag = 3;
    }
    return _imageView3;
}

//- (UIView *)bottomView {
//    if (!_bottomView) {
//        _bottomView = [[UIView alloc] initForAutoLayout];
//        _bottomView.backgroundColor = [UIColor swpColorFromRGB:247 green:247 blue:247 alpha:1];
//
//    }
//    return _bottomView;
//}

@end
