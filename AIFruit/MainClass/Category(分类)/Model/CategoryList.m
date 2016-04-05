//
//  CategoryList.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "CategoryList.h"

@implementation CategoryList


+(CategoryList *)setupCategoryList:(NSDictionary *)dic{
    CategoryList *list = [[CategoryList alloc]init];
    list.id = [[dic valueForKey:@"id"]intValue];
    list.cateName = [dic valueForKey:@"cateName"];
    list.detailName = [dic valueForKey:@"detailName"];
    list.iconName = [dic valueForKey:@"iconName"];
    return list;
}

@end
