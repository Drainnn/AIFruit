//
//  NSURL+AIFruitURL.h
//  AIFruit
//
//  Created by Kosne on 16/4/21.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (AIFruitURL)

+(NSURL *)getMainImgURLWithId:(int)id andmainImgUrl:(NSString *)imgUrl;

+(NSURL *)getDetailImgUrlWithId:(int)id anddetailImgUrl:(NSString *)imgUrl;

+(NSURL *)getShouyejingxuanImgUrlWithId:(int)id andImgUrl:(NSString *)imgUrl;

@end
