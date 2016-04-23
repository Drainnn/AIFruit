//
//  NSString+AIFruitString.m
//  AIFruit
//
//  Created by Kosne on 16/4/21.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "NSString+AIFruitString.h"

@implementation NSString (AIFruitString)


+(NSAttributedString *)setOriginPriceWithPrice:(double)originPrice{
    //原价
    NSString *originPriceStr = [NSString stringWithFormat:@"￥%.1f",originPrice];
    NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:originPriceStr attributes:@{NSForegroundColorAttributeName:UIColorWithRGBA(196, 196, 196, 1.0f),NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSStrikethroughColorAttributeName:UIColorWithRGBA(196, 196, 196, 1.0f)}];
    return attStr;
}


@end
