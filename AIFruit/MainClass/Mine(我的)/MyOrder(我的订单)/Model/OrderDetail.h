//
//  OrderDetail.h
//  AIFruit
//
//  Created by Kosne on 16/5/11.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetail : NSObject

@property (nonatomic, assign) int id;

@property (nonatomic, assign) int userId;

@property (nonatomic, copy) NSString *orderNO;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) int goodsPrice;

@property (nonatomic, assign) int freight;

@property (nonatomic, assign) int totalPrice;

@property (nonatomic, assign) int isBill;

@property (nonatomic, copy) NSString *payway;

@property (nonatomic, copy) NSString *receiveUser;

@property (nonatomic, copy) NSString *addressArea;

@property (nonatomic, copy) NSString *detailAD;

@property (nonatomic, copy) NSString *contact;

@property (nonatomic, copy) NSString *sendTime;

@property (nonatomic, strong) NSArray *fruitLists;


@end
