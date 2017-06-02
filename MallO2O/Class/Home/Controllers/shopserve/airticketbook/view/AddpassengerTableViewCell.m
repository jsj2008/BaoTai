//
//  AddpassengerTableViewCell.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/11.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "AddpassengerTableViewCell.h"
#import "PassengerModel.h"

@interface AddpassengerTableViewCell ()<UITextFieldDelegate>

@property (strong ,nonatomic) UITextField *inputTextField;

@property (copy ,nonatomic) NSIndexPath *selectIndexPath;

@end

@implementation AddpassengerTableViewCell

+ (instancetype)addPassengerCellOfTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCellIdentifier:(NSString *)cellID{
    AddpassengerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectIndexPath = indexPath;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSelfUI];
        [self setSelfAutoLayout];
    }
    return self;
}

- (void)addSelfUI{
    [self.contentView addSubview:self.inputTextField];
}

- (void)setSelfAutoLayout{
    
}


- (UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] initForAutoLayout];
        _inputTextField.textAlignment = NSTextAlignmentRight;
        _inputTextField.font = [UIFont systemFontOfSize:15];
        [_inputTextField addTarget:self action:@selector(textFieldInfoChanged:) forControlEvents:UIControlEventEditingChanged];
        _inputTextField.textColor = UIColorFromRGB(0x888888);
        _inputTextField.delegate = self;
    }
    return _inputTextField;
}

- (void)getAddpassengerTableViewCellBlock:(AddpassengerTableViewCellBlock)block{
    self.block = block;
}

- (void)textFieldInfoChanged:(UITextField *)textField{
    if (self.block) {
        self.block(textField.text,self.selectIndexPath.section,self.selectIndexPath.row);
    }
}

- (void)setAddModel:(PassengerModel *)addModel{
    _addModel = addModel;
    [self setData];
    [self setCellType];
}

- (void)setCellType{
    self.accessoryType = _addModel.cellAccessoryType;
    if (_addModel.cellAccessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        [self.inputTextField autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 0, 5, 0) excludingEdge:ALEdgeLeft];
        [self.inputTextField autoSetDimension:ALDimensionWidth toSize:200];
    }
    else{
        [self.inputTextField autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 0, 5, 15) excludingEdge:ALEdgeLeft];
        [self.inputTextField autoSetDimension:ALDimensionWidth toSize:200];
    }
}

- (void)setData{
    if ([_addModel.key isEqualToString:@"tel"]) {
        self.inputTextField.keyboardType =  UIKeyboardTypePhonePad;
    }
    if ([_addModel.key isEqualToString:@"email"]) {
        self.inputTextField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    self.inputTextField.enabled = self.addModel.textFieldCanEdit;
    self.inputTextField.placeholder = self.addModel.placeholderString;
    if (self.addModel.detailString != nil) {
        self.inputTextField.text = self.addModel.detailString;
    }
    self.superModel = self.addModel;
}



@end
