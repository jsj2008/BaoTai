//
//  CanlendarViewController.m
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/17.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "CanlendarViewController.h"

#import <FSCalendar/FSCalendar.h>

@interface CanlendarViewController ()<FSCalendarDataSource ,FSCalendarDelegate>

@property (strong ,nonatomic) FSCalendar *calendar;

@end

@implementation CanlendarViewController

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
    [self setNavBarTitle:@"日历" withFont:NAV_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.calendar];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}

- (void)clickDateAndGetIt:(CanlendarViewControllerBlock)block{
    self.dateBlock = block;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date{
    NSLog(@"%@",date);
    if (self.dateBlock) {
        self.dateBlock(date ,calendar);
    }
}

- (FSCalendar *)calendar{
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _calendar.delegate = self;
        _calendar.dataSource = self;
//        _calendar.showsPlaceholders = YES;
//        _calendar.currentPage = [_calendar dateFromString:@"2016-06" format:@"yyyy-MM"];
    }
    return _calendar;
}

@end
