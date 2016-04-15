//
//  detailFruit.h
//  AIFruit
//
//  Created by Kosne on 16/4/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface detailFruit : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *fruitName;
@property (nonatomic, assign) int categoryID;
@property (nonatomic, assign) double originPrice;
@property (nonatomic, assign) double privilegePrice;
@property (nonatomic, copy) NSString *singleStandard;
@property (nonatomic, copy) NSString *standard;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, assign) int saleNum;
@property (nonatomic, assign) int stockNum;



@end
