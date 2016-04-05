//
//  CategoryList.h
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryList : NSObject

@property (nonatomic, assign) int id;

@property (nonatomic, copy) NSString *cateName;

@property (nonatomic, copy) NSString *detailName;

@property (nonatomic, copy) NSString *iconName;

+(CategoryList *)setupCategoryList:(NSDictionary *)dic;

@end
