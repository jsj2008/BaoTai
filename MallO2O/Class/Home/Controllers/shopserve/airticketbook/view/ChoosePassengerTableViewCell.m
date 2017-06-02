//
//  ChoosePassengerTableViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/11.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "ChoosePassengerTableViewCell.h"
#import "AddPassengerViewController.h"
@interface ChoosePassengerTableViewCell ()


@property (strong ,nonatomic) UILabel *nameLabel;

@property (strong ,nonatomic) UILabel *passPortLabel;





@end

@implementation ChoosePassengerTableViewCell {
    
    
}

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
//        [self setSelected:NO];
    }
    return self;
}

+ (instancetype)choosePassengerCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath cellIdentifier:(NSString *)identifier{
    ChoosePassengerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  添加控件
 */
- (void)addUI{
//    [self.contentView addSubview:self.choosImageView];
    [self.contentView addSubview:self.choosButton];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.passPortLabel];
    [self.contentView addSubview:self.editButton];
}
/**
 *  设置自动布局
 */
- (void)setAutoLayout{
//    [self.choosImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
//    [self.choosImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//    [self.choosImageView autoSetDimension:ALDimensionHeight toSize:15];
//    [self.choosImageView autoSetDimension:ALDimensionWidth toSize:15];
    
    [self.choosButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.choosButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.choosButton autoSetDimension:ALDimensionHeight toSize:15];
    [self.choosButton autoSetDimension:ALDimensionWidth toSize:15];
    
    [self.nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.choosButton withOffset:10];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.nameLabel autoSetDimension:ALDimensionHeight toSize:25*Balance_Heith];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    
    [self.passPortLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.choosButton withOffset:10];
    [self.passPortLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.passPortLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    [self.passPortLabel autoSetDimension:ALDimensionHeight toSize:25 *Balance_Heith];
    
    [self.editButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeLeft];
    [self.editButton autoSetDimension:ALDimensionWidth toSize:50];
}

/**
 *  设置选择乘机人图片
 *
 *  @param selectedType 选择状态
 */
//- (void)setCellSelected:(BOOL)selectedType{
//    if (selectedType) {
//        self.choosImageView.image = [UIImage imageNamed:@"address_sel"];
//    }else{
//        
//        self.choosImageView.image = [UIImage imageNamed:@"address_no"];
//    }
//    
//    selectedType = !selectedType;
//    
//}

- (void)getButtonAction:(BlockButton)button {
    
    self.button = button;
}


// 编辑按钮
- (void)clickEditPassengerInfo:(UIButton *)button{
    
    if (self.button) {
        self.button();
    }
    
//    AddPassengerViewController *vc = [[AddPassengerViewController alloc] init];
//    vc.personModel = _dataList;
//    vc.type = YES;
//    [self.viewControllerll.navigationController pushViewController:vc animated:YES];
    
}

// 获取视图所在的控制器
//- (UIViewController *)viewControllerll {
//    
//    //通过响应者链，取得此视图所在的视图控制器
//    UIResponder *next = self.nextResponder;
//    
//    do {
//        
//        //判断响应者对象是否是视图控制器类型
//        if ([next isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)next;
//        }
//        
//        next = next.nextResponder;
//        
//    }while(next != nil);
//    
//    return nil;
//}


- (void)setDataList:(AddPesonModel *)dataList {
    
    _dataList = dataList;
    _nameLabel.text = self.dataList.name;
    _passPortLabel.text = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"choosePassengerCellPassportNumber", nil),self.dataList.passport];
    _choosButton.selected = dataList.typ;
}


#pragma mark - 控件初始化


- (UIButton *)choosButton {
    if (!_choosButton) {
        
        _choosButton = [[UIButton alloc] initForAutoLayout];
        [_choosButton setImage:[UIImage imageNamed:@"address_no"] forState:UIControlStateNormal];
        [_choosButton setImage:[UIImage imageNamed:@"address_sel"] forState:UIControlStateSelected];
    
    }
    return _choosButton;
    
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initForAutoLayout];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = UIColorFromRGB(0x454545);
        
    }
    return _nameLabel;
}

- (UILabel *)passPortLabel{
    if (!_passPortLabel) {
        _passPortLabel = [[UILabel alloc] initForAutoLayout];
        _passPortLabel.textColor = UIColorFromRGB(0x898989);
        _passPortLabel.font = [UIFont systemFontOfSize:15];
       
    }
    return _passPortLabel;
}

- (UIButton *)editButton{
    if (!_editButton) {
        _editButton = [[UIButton alloc] initForAutoLayout];
        [_editButton setTitle:NSLocalizedString(@"choosePassengerCellEditor", nil) forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_editButton setTitleColor:UIColorFromRGB(0x454545) forState:UIControlStateNormal];
        [_editButton addTarget:self action:@selector(clickEditPassengerInfo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

@end
