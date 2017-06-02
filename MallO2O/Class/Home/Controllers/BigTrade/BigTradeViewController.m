//
//  BigTradeViewController.m
//  MallO2O
//
//  Created by songweiping on 16/3/21.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "BigTradeViewController.h"

/*! ---------------------- Tool       ---------------------- !*/
#import "UIColor+SwpColor.h"
#import <Masonry/Masonry.h>
#import "SwpWeakifyHeader.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <DOPDropDownMenu-Enhanced/DOPDropDownMenu.h>
/*! ---------------------- Tool       ---------------------- !*/

/*! ---------------------- Controller ---------------------- !*/
#import "BigTradeInfoViewController.h"
#import "BigTradeOrderViewController.h"
/*! ---------------------- Controller ---------------------- !*/

/*! ---------------------- View       ---------------------- !*/
#import "BigTradeCell.h"
/*! ---------------------- View       ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/
#import "BigTradeCateModel.h"
#import "BigTradeSortModel.h"
#import "BigTradeModel.h"
#import "PersonInfoModel.h"
/*! ---------------------- Model      ---------------------- !*/


static  NSString * const kBigTradeCellID = @"bigTradeCellID";

@interface BigTradeViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, DOPDropDownMenuDataSource, DOPDropDownMenuDelegate>

#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView           *bigTradeCollectionView;
/*! 显示商家分类view !*/
@property (nonatomic, strong) DOPDropDownMenu            *screenCateView;
/*! ---------------------- UI   Property  ---------------------- !*/

#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
@property (nonatomic, copy  ) NSArray                    *screenArray;
@property (nonatomic, strong) NSMutableArray             *bigTradeArray;
@property (nonatomic, copy  ) NSString                   *screenCateID;
@property (nonatomic, copy  ) NSString                   *screenSortID;
@property (nonatomic, assign) NSInteger                  page;
/*! ---------------------- Data Property  ---------------------- !*/


@end

@implementation BigTradeViewController

#pragma mark - Lifecycle Methods
/*!
 *  @author swp_song
 *
 *  @brief  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingUI];
    
    [self settingData];
}

/*!
 *  @author swp_song
 *
 *  @brief  将要加载出视图 调用
 *
 *  @param  animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];

}

/*!
 *  @author swp_song
 *
 *  @brief  视图 显示 窗口时 调用
 *
 *  @param  animated
 */
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


/*!
 *  @author swp_song
 *
 *  @brief 视图  即将消失、被覆盖或是隐藏时调用
 *
 *  @param animated
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Do any additional setup after loading the view.
}

/*!
 *  @author swp_song
 *
 *  @brief  视图已经消失、被覆盖或是隐藏时调用
 *
 *  @param  animated
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

/*!
 *  @author swp_song
 *
 *  @brief  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*!
 *  @author swp_song
 *
 *  @brief  当前 控制器 被销毁时 调用
 */
- (void) dealloc {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - Setting Data Method
/*!
 *  @author swp_song
 *
 *  @brief  设置 初始化 数据
 */
- (void) settingData {
    
    self.screenCateID = @"0";
    self.screenSortID = @"0";
    self.page         = 1;
    [self bigTradeGetCateData];
    
    [self dataObserve];
    
}

#pragma mark - Setting UI Methods
/*!
 *  @author swp_song
 *
 *  @brief  设置 UI 控件
 */
- (void) settingUI {
    
    [self settingNavigationBar];
    [self setUpUI];
    [self settingUIAutoLayout];
    
}


/*!
 *  @author swp_song
 *
 *  @brief  设置导航栏
 */
- (void) settingNavigationBar {
    [self setNavBarTitle:self.navigationTitle withFont:NAV_TITLE_FONT_SIZE];
    [self setBackButton];
}

/*!
 *  @author swp_song
 *
 *  @brief  setupUI ( 添加控件 | 设置控件自动布局 )
 */
- (void) setUpUI {
    
    [self.view addSubview:self.screenCateView];
    [self.view addSubview:self.bigTradeCollectionView];
}

/*!
 *  @author swp_song
 *
 *  @brief  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
    @swpWeakify(self);
    [self.bigTradeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @swpStrongify(self);
        make.top.equalTo(self.screenCateView.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.bigTradeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    BigTradeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBigTradeCellID forIndexPath:indexPath];
    cell.bigTrade = self.bigTradeArray[indexPath.row];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(([SwpTools swpToolScreenWidth] - 5) / 2, [SwpTools swpToolScreenScale:([SwpTools swpToolScreenWidth] - 5) / 2 scaleWidth:3 scaleHeight:4]);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BigTradeModel              *bigTrade     = self.bigTradeArray[indexPath.row];
    BigTradeInfoViewController *bigTradeInfo = [BigTradeInfoViewController new];
    bigTradeInfo.bigTradeInfoURL             = bigTrade.bigTradeInfoURL;
    [self.navigationController pushViewController:bigTradeInfo animated:YES];
    
    
//    [self.navigationController pushViewController:[BigTradeOrderViewController new] animated:YES];
}


#pragma mark - DOPDropDownMenu DataSource Methods

/*!
 *  @author swp_song
 *
 *  @brief  DOPDropDownMenu DataSource ( dopDropDownMenu 数据源方法 设置 显示 分类的个数  )
 *
 *  @param  menu
 *
 *  @return
 */
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return self.screenArray.count;;
}

/*!
 *  @author swp_song
 *
 *  @brief  DOPDropDownMenu DataSource ( dopDropDownMenu 数据源方法 设置 显示 一级分类个数 )
 *
 *  @param  menu
 *
 *  @param  column
 *
 *  @return NSInteger
 */
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    
    if (column == -1) return 0;
    NSArray *array = self.screenArray[column];
    return array.count;
}

/*!
 *  @author swp_song
 *
 *  @brief  DOPDropDownMenu DataSource ( dopDropDownMenu 数据源方法 设置 显示 一级分类名称 )
 *
 *  @param  menu
 *
 *  @param  indexPath
 *
 *  @return NSString
 */
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    BigTradeCateModel *bigTradeCate = self.screenArray[indexPath.column][indexPath.row];
    return bigTradeCate.bigTradeCateName;
}

#pragma mark - DOPDropDownMenu Delegate Methods
/*!
 *  @author swp_song
 *
 *  @brief  DOPDropDownMenu Delegate ( dopDropDownMenu 代理方法 点击 每个分类调用 )
 *
 *  @param  menu
 *
 *  @param  indexPath
 */
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    
    
    self.page                       = 1;
    self.bigTradeArray              = [NSMutableArray array];
    [self.bigTradeCollectionView reloadData];

    BigTradeCateModel *bigTradeCate = self.screenArray[indexPath.column][indexPath.row];
    
    if ([self.screenArray[indexPath.column][indexPath.row] isKindOfClass:[BigTradeSortModel class]]) {
        self.screenSortID = bigTradeCate.bigTradeCateID;
    } else {
        self.screenCateID = bigTradeCate.bigTradeCateID;
        
    }
    
    [self bigTradeGetListData:self.screenCateID sortID:self.screenSortID];
    
}

- (void)bigTradeGetCateData {
    
    NSString     *url        = [SwpTools swpToolGetInterfaceURL:@"big_trade"];
    NSDictionary *dictionary = @{
                                 @"app_key" : url,
                                 @"page"    : @"1",
                                 @"type"    : self.listType
                                 };
    [self swpPublicTooGetDataToServer:url parameters:dictionary isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        NSArray *cateArray = [BigTradeCateModel bigTradeCateWihtArray:resultObject[self.swpNetwork.swpNetworkObject][@"cate"]];
        NSArray *listArray = resultObject[self.swpNetwork.swpNetworkObject][@"default"];
        self.screenArray   = @[cateArray, [BigTradeSortModel bigTradeSortWithArray]];
        self.bigTradeArray = [BigTradeModel bigTradeWithArray:listArray];
        [self.screenCateView reloadData];
        [self.bigTradeCollectionView reloadData];
        
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
    
    
}

- (void)bigTradeGetListData:(NSString *)cateID sortID:(NSString *)sortID {
    
    NSString     *url        = [SwpTools swpToolGetInterfaceURL:@"big_trade_info"];
    NSDictionary *dictionary = @{
                                 @"app_key" : url,
                                 @"cate_id" : cateID,
                                 @"sort_id" : sortID,
                                 @"page"    : [NSString stringWithFormat:@"%ld", (long)self.page],
                                 @"type"    : self.listType
                                 };
    [self swpPublicTooGetDataToServer:url parameters:dictionary isEncrypt:self.swpNetwork.swpNetworkEncrypt swpResultSuccess:^(id  _Nonnull resultObject) {
        [self.bigTradeCollectionView.mj_footer resetNoMoreData];
        NSArray *array = resultObject[self.swpNetwork.swpNetworkObject];
        if (array.count != 0) {
            self.bigTradeArray = [BigTradeModel bigTradeWithArray:array accedeToArray:self.bigTradeArray];
            [self.bigTradeCollectionView reloadData];
        } else {
            [self.bigTradeCollectionView.mj_footer endRefreshingWithNoMoreData];
            [SVProgressHUD showSuccessWithStatus:self.swpNetwork.swpNetworkNotData];
        }
    } swpResultError:^(id  _Nonnull resultObject, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

#pragma mark - Data Rereshing Methods
/*!
 *  @author swp_song
 *
 *  @brief  footerRereshingData ( 头部刷新方法 <下拉刷新数据> )
 */
- (void) headerRereshingData {
    self.page = 1;
    [self.bigTradeArray removeAllObjects];
    [self bigTradeGetListData:self.screenCateID sortID:self.screenSortID];
    [self.bigTradeCollectionView.mj_header endRefreshing];
}

/*!
 *  @author swp_song
 *
 *  @brief  footerRereshingData ( 尾部刷新方法 <上拉刷加载更多数据> )
 */
- (void) footerRereshingData {
    self.page++;
    [self bigTradeGetListData:self.screenCateID sortID:self.screenSortID];
    [self.bigTradeCollectionView.mj_footer endRefreshing];
}


/*!
 *  @author swp_song
 *
 *  @brief  dataObserve ( 数据 监听方法 )
 */
- (void)dataObserve {
    
    @swpWeakify(self);
    
    [RACObserve(self, self.screenArray) subscribeNext:^(NSArray * dataSource) {
        if (dataSource.count != 0) [UIView animateWithDuration:1 animations:^{
            @swpStrongify(self);
            self.screenCateView.alpha = 1;
        }];
    }];
    
    [RACObserve(self, self.bigTradeArray) subscribeNext:^(NSArray *dataSoure) {
        @swpStrongify(self);
        self.bigTradeCollectionView.mj_footer.hidden = dataSoure.count == 0 ? YES : NO;
    }];
}



- (DOPDropDownMenu *)screenCateView {
    
    return !_screenCateView ? _screenCateView = ({
        DOPDropDownMenu *dopDropDownMenu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointZero andHeight:44];
        dopDropDownMenu.dataSource       = self;
        dopDropDownMenu.delegate         = self;
        dopDropDownMenu.alpha            = 0;
//        dopDropDownMenu.indicatorColor   = [UIColor swpColorFromRGB:17 green:176 blue:244 alpha:1];
        dopDropDownMenu.textSelectedColor = [UIColor swpColorFromRGB:17 green:176 blue:244 alpha:1];
        dopDropDownMenu.backgroundColor  = [UIColor swpColorFromHEX:0xf6f5f5];
        
        dopDropDownMenu;
    }) : _screenCateView;
}


- (UICollectionView *)bigTradeCollectionView {
    return !_bigTradeCollectionView ? _bigTradeCollectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        collectionView.backgroundColor   = [UIColor whiteColor];
        collectionView.dataSource        = self;
        collectionView.delegate          = self;
        [collectionView registerClass:[BigTradeCell class] forCellWithReuseIdentifier:kBigTradeCellID];
        [self swpPublicToolSettingCollectionViewRefreshing:collectionView target:self headerAction:@selector(headerRereshingData) footerAction:@selector(footerRereshingData)];
        collectionView;
    }) : _bigTradeCollectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    
    return !_flowLayout ? _flowLayout = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection             = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing          = 5;
        flowLayout.minimumInteritemSpacing     = 0;
        flowLayout;
    }) : _flowLayout;
}

- (NSArray *)screenArray {
    return !_screenArray ? _screenArray = [NSArray array] : _screenArray;
}


- (NSMutableArray *)bigTradeArray {
    return !_bigTradeArray ? _bigTradeArray = [NSMutableArray array] : _bigTradeArray;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
