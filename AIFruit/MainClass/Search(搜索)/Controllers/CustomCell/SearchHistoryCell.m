//
//  SearchHistoryCell.m
//  AIFruit
//
//  Created by Kosne on 16/3/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "SearchHistoryCell.h"

@implementation SearchHistoryCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor);
//    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    
    //下分割线
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"e2e2e2"].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}


@end
