//
//  AgreementView.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/26.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "AgreementView.h"
#import <Masonry/Masonry.h>

@interface AgreementView ()

@property (strong ,nonatomic) UIWebView *webView;

@property (strong ,nonatomic) UIButton  *agreeButton;

@end

@implementation AgreementView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

- (void)addUI{
    [self addSubview:self.webView];
    [self addSubview:self.agreeButton];
}

- (void)settingAutoLayout{
//    [self.webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 40, 0)];
    __weak typeof(self) view = self;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(view);
        make.bottom.equalTo(view).offset(-80);
    }];
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.bottom.offset(-20);
        make.height.offset(40);
    }];
}

- (void)setWebUrl:(NSString *)webUrl{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]];
    [self.webView loadRequest:request];
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.bounces = NO;
    }
    return _webView;
}

- (UIButton *)agreeButton{
    if (!_agreeButton) {
        _agreeButton = [[UIButton alloc] init];
//        _agreeButton.backgroundColor = UIColorFromRGB(0x1A9DED);
        _agreeButton.layer.borderColor = UIColorFromRGB(0x1a9ded).CGColor;
        _agreeButton.layer.borderWidth = 0.8;
        [_agreeButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        [_agreeButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
        [_agreeButton setTitleColor:UIColorFromRGB(0x1a9ded) forState:UIControlStateNormal];
        _agreeButton.layer.cornerRadius = 5;
        _agreeButton.layer.masksToBounds = YES;
    }
    return _agreeButton;
}

- (void)setClickButtonBlock:(AgreementViewBlock)block{
    self.block = block;
}

- (void)clickButton{
    if (self.block) {
        self.block();
    }
}

@end
