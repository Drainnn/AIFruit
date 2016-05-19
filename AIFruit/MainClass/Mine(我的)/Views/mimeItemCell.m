//
//  mimeItemCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/26.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "mimeItemCell.h"


@implementation mimeItemCell

-(void)setupCellWithIndex:(NSInteger)index{

    self.ItemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(27, 30, 40, 40)];
    [self.bgLabel addSubview:self.ItemImageView];
    

    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(24, 75, 80, 24)];
    [self.titleLabel setFont:UIFontWithSize(12)];
    [self.titleLabel setTextColor:[UIColor grayColor]];
    
    if (index == 0) {
        [self setImg:@"mine_order" andLabel:@"我的订单"];
    }else if (index == 1){
        [self setImg:@"mine_personal" andLabel:@"个人中心"];
    }else if (index == 2){
        [self setImg:@"mine_comment" andLabel:@"我的评价"];
    }else if (index == 3){
        [self setImg:@"mine_address" andLabel:@"收货地址"];
    }
    
    [self addSubview:self.ItemImageView];
    [self addSubview:self.titleLabel];
    
}

-(void)setImg:(NSString *)imgName andLabel:(NSString *)titleStr{
    self.ItemImageView.image = [UIImage imageNamed:imgName];
    self.titleLabel.text = titleStr;
}

@end
