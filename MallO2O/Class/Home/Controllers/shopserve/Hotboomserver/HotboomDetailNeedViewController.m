//
//  HotboomDetailNeedViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/22.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "HotboomDetailNeedViewController.h"

#import "SwpTextView.h"

@interface HotboomDetailNeedViewController ()

@property (strong ,nonatomic) SwpTextView *textView;

@property (copy   ,nonatomic) NSString *inputText;

@end

@implementation HotboomDetailNeedViewController

#pragma mark - 生命周期方法
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  将要加载出视图 调用
 *
 *  @param animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - 初始化数据
/**
 *  数据初始化
 */
- (void) initData {
    
}

#pragma mark - 设置UI控件
/**
 *  初始化UI控件
 */
- (void) initUI {
    
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    [self setNavBarTitle:NSLocalizedString(@"hotboomServeViewControllerDetailNeedNavigaitonTitle", nil) withFont:NAV_TITLE_FONT_SIZE];
    [self setRightButton];
    [self setBackButton];
}

/**
 *  设置导航栏右侧按钮
 */
- (void)setRightButton{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 34);
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [rightButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
    [rightButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateHighlighted];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)getDetailInfo:(HotboomDetalNeedBlock)block{
    self.detailNeedBlock = block;
}

- (void)clickRightButton{
    if (self.detailNeedBlock) {
        self.detailNeedBlock(self.inputText);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view setBackgroundColor:UIColorFromRGB(0xf4f4f4)];
    [self.view addSubview:self.textView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.textView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.textView autoSetDimension:ALDimensionHeight toSize:200];
}

- (SwpTextView *)textView{
    if (!_textView) {
        __weak typeof(self) vc = self;
        _textView = [[SwpTextView alloc] initForAutoLayout];
        [_textView swpTextViewChangeText:^(SwpTextView * _Nonnull swpTextView, NSString * _Nonnull changeText) {
            vc.inputText = changeText;
        }];
        _textView.swpTextViewPlaceholder = NSLocalizedString(@"hotboomServeViewControllerDetailNeedText", nil);
    }
    return _textView;
}

@end
