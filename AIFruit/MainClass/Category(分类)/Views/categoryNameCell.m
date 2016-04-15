//
//  categoryNameCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/10.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "categoryNameCell.h"

@implementation categoryNameCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setupCellWithIndex:(NSInteger)index{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    label.text = [NSString stringWithFormat:@"nihao:%ld",index];
    [self addSubview:label];
}

@end
