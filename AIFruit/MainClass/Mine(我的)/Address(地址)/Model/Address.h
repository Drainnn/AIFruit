//
//  Address.h
//  AIFruit
//
//  Created by Kosne on 16/4/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, assign) int UserID;
@property (nonatomic, copy) NSString *receiveUser;
@property (nonatomic, assign) int isDefault;
@property (nonatomic, copy) NSString *addressArea;
@property (nonatomic, copy) NSString *detailAD;
@property (nonatomic, copy) NSString *contact;

@end
