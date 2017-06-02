//
//  BigTradeModel.h
//  MallO2O
//
//  Created by songweiping on 16/3/23.
//  Copyright © 2016年 songweipng. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface BigTradeModel : NSObject


@property (nonatomic, copy) NSString *bigTradeImageURL;
@property (nonatomic, copy) NSString *bigTradeID;
@property (nonatomic, copy) NSString *bigTradeName;
@property (nonatomic, copy) NSString *bigTradeInfoURL;
@property (nonatomic, copy) NSString *bigTradePrice;

+ (instancetype)bigTradeWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSMutableArray<BigTradeModel *> *)bigTradeWithArray:(NSArray<NSDictionary *> *)dictionaryArray;

+ (NSMutableArray<BigTradeModel *> *)bigTradeWithArray:(NSArray<NSDictionary *> *)dictionaryArray accedeToArray:(NSArray<BigTradeModel *> *)oldDataArray;

@end

NS_ASSUME_NONNULL_END
