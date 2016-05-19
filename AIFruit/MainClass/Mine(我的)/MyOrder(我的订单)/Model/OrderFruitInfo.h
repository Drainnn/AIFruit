//
//  OrderFruitInfo.h
//  AIFruit
//
//  Created by Kosne on 16/5/11.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderFruitInfo : NSObject

@property (nonatomic, assign) int fruitId;
@property (nonatomic, assign) int num;
@property (nonatomic, copy) NSString *fruitName;
@property (nonatomic, copy) NSString *singleStandard;
@property (nonatomic, assign) int privilegePrice;
@property (nonatomic, copy) NSString *mainImgUrl;

@end
