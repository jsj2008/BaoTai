//
//  DestineViewController.h
//  MallO2O
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import "MallO2OBaseViewController.h"

@interface DestineViewController : MallO2OBaseViewController

@property (copy ,nonatomic) NSString *webUrl;

@property (copy ,nonatomic) NSString *webTitle;

@property (copy ,nonatomic) NSString *identifier;

@property (copy ,nonatomic) NSArray *p_idArray;

// 请求体
@property (copy ,nonatomic) NSString *body;

- (void)reloadWebView:(NSString *)urla;


@end
