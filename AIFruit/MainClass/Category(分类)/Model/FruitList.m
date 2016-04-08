//
//  FruitList.m
//  AIFruit
//
//  Created by Kosne on 16/3/16.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "FruitList.h"

@implementation FruitList

+(FruitList *)setupFruitListWithDict:(NSDictionary *)dict{
    FruitList *info = [[FruitList alloc]init];
    info.id = [[dict valueForKey:@"id"]intValue];
    info.mainImgUrl = [dict valueForKey:@"mainImgUrl"];
    info.saleNum = [[dict valueForKey:@"saleNum"]intValue];
    info.fruitName = [dict valueForKey:@"FruitName"];
    info.originPrice = [[dict valueForKey:@"originPrice"] doubleValue];
    info.privilegePrice = [[dict valueForKey:@"privilegePrice"] doubleValue];
    info.standard = [dict valueForKey:@"standard"];
    info.stockNum = [[dict valueForKey:@"stock"] intValue];
    
    return info;
    
}

@end
