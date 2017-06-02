//
//  AgreementView.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/26.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AgreementViewBlock)();

@interface AgreementView : UIView

//@property (copy ,nonatomic)
@property (copy ,nonatomic) NSString *webUrl;

- (void)setClickButtonBlock:(AgreementViewBlock)block;

@property (copy ,nonatomic) AgreementViewBlock block;

@end
