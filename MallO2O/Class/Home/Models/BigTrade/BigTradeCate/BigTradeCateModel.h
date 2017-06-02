//
//  BigTradeCateModel.h
//  MallO2O
//
//  Created by songweiping on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BigTradeCateModel : NSObject


@property (nonatomic, copy) NSString *bigTradeCateID;
@property (nonatomic, copy) NSString *bigTradeCateName;


+ (instancetype)bigTradeCateWihtDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)bigTradeCateWithBigTradeCateID:(NSString *)bigTradeCateID bigTradeCateName:(NSString *)bigTradeCateName;

+ (NSArray<BigTradeCateModel *> *)bigTradeCateWihtArray:(NSArray<NSDictionary *> *)dictionaryArray;

@end
