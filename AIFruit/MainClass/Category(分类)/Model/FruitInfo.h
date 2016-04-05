//
//  FruitInfo.h
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FruitInfo : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *FruitName;
@property (nonatomic, assign) int categoryID;
@property (nonatomic, assign) double OriginPrice;
@property (nonatomic, assign) double PrivilegePrice;
@property (nonatomic, copy) NSString *singleStandard;
@property (nonatomic, copy) NSString *standard;
@property (nonatomic, assign) int AreaID;
@property (nonatomic, assign) int stock;


+(FruitInfo *)setupFruitInfoWithDict:(NSDictionary *)dict;

@end
