//
//  SeeGoodsHistoryModel.h
//  MallO2O
//
//  Created by zhiyuan gao on 16/3/28.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeeGoodsHistoryModel : NSObject

@property (copy ,nonatomic) NSString *secondTitleText;

@property (copy ,nonatomic) NSString *secondNowPriceText;

@property (copy ,nonatomic) NSString *secondOldPriceText;

@property (copy ,nonatomic) NSString *secondTimeText;

@property (copy ,nonatomic) NSString *secondImgUrlText;

@property (copy ,nonatomic) NSString *secondGoodsId;

@property (copy ,nonatomic) NSString *secondPersonNum;

@property (copy ,nonatomic) NSString *secondShopName;

@property (copy ,nonatomic) NSString *secondGrading;

@property (copy ,nonatomic) NSString *webUrl;

@property (copy ,nonatomic) NSString *collect_id;

@property (copy ,nonatomic) NSString *goods_detail;
/**
 *  售出数量
 */
@property (copy ,nonatomic) NSString *saleNum;

@property (copy ,nonatomic) NSString *isHot;

+ (instancetype)arrayWithDic:(NSDictionary *)dic;

@end
