//
//  Order.h
//  AIFruit
//
//  Created by Kosne on 16/5/9.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *orderNO;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) int state;
@property (nonatomic, assign) int totalPrice;
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, strong) NSArray *imgUrls;

@end
