//
//  Comment.h
//  AIFruit
//
//  Created by Kosne on 16/4/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject


@property (nonatomic, assign) int fruitID;
@property (nonatomic, copy) NSString *mobileNo;
@property (nonatomic, assign) int score;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *pushTime;

@end
