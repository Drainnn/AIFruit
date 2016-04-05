//
//  FruitList.h
//  AIFruit
//
//  Created by Kosne on 16/3/16.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FruitList : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *mainImgUrl;
@property (nonatomic, copy) NSString *standard;
@property (nonatomic, assign) int saleNum;
@property (nonatomic, copy) NSString *fruitName;
@property (nonatomic, assign) double originPrice;
@property (nonatomic, assign) double privilegePrice;
@property (nonatomic, assign) int stockNum;

+(FruitList *)setupFruitListWithDict:(NSDictionary *)dict;

@end
