//
//  UserInfo.h
//  AIFruit
//
//  Created by Kosne on 16/4/26.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *mobileNo;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, assign) int headImgID;
@property (nonatomic, assign) int sex;
@property (nonatomic, assign) int grade;
@property (nonatomic, assign) int allPoint;
@property (nonatomic, assign) int currentPoint;
@property (nonatomic, copy) NSString *registTime;

@end
