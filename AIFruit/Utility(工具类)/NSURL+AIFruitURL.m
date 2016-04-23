//
//  NSURL+AIFruitURL.m
//  AIFruit
//
//  Created by Kosne on 16/4/21.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "NSURL+AIFruitURL.h"

@implementation NSURL (AIFruitURL)

+(NSURL *)getImgURLWithId:(int)id andmainImgUrl:(NSString *)imgUrl{
    NSString *imgStr = [NSString stringWithFormat:@"%@/%@/%@",mainImgUrlPrefix,[NSString stringWithFormat:@"%d",id],imgUrl];
    NSURL *url = [[NSURL alloc]initWithString:[imgStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return url;
}

@end
