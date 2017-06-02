//
//  BannerImgModel.m
//  MallO2O
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "BannerImgModel.h"

@implementation BannerImgModel

+ (instancetype)modelWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        _bannerImgID = dic[@"banner_id"];
        _bannerImgUrl = dic[@"banner_img"];
        _bannerTurnUrl = dic[@"banner_url"];
        _bannerDetialUrl = dic[@"banner_desc"];
        _url = dic[@"url"];
    }
    return self;
}

@end
