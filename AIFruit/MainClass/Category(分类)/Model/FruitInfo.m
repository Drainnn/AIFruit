//
//  FruitInfo.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "FruitInfo.h"

@implementation FruitInfo

+(FruitInfo *)setupFruitInfoWithDict:(NSDictionary *)dict{
    FruitInfo *info = [[FruitInfo alloc]init];
    info.id = [[dict valueForKey:@"id"]intValue];
    info.FruitName = [dict valueForKey:@"FruitName"];
    info.categoryID = [[dict valueForKey:@"categoryID"] intValue];
    info.OriginPrice = [[dict valueForKey:@"originPrice"] doubleValue];
    info.PrivilegePrice = [[dict valueForKey:@"PrivilegePrice"] doubleValue];
    info.singleStandard = [dict valueForKey:@"SingleStandard"];
    info.standard = [dict valueForKey:@"standard"];
    info.AreaID = [[dict valueForKey:@"AreaID"] intValue];
    info.stock = [[dict valueForKey:@"stock"] intValue];
    
    return info;
}


@end
