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
//    self.bgLabel = [[UILabel alloc]initWithFrame:CGRectMake(24, 24, 50, 50)];
//    [self.bgLabel setBackgroundColor:themeColor];
//    self.bgLabel.layer.cornerRadius = 12;
//    self.bgLabel.layer.borderColor = [[UIColor grayColor] CGColor];
//    self.bgLabel.layer.borderWidth = 3;
    self.ItemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(24, 24, 32, 32)];
//    self.ItemImageView.center = self.bgLabel.center;
    [self.bgLabel addSubview:self.ItemImageView];
    self.ItemImageView.layer.cornerRadius = 16;
    self.ItemImageView.layer.borderWidth = 3;
    self.ItemImageView.layer.borderColor = themeColor.CGColor;
    self.ItemImageView.layer.masksToBounds = YES;

    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(24, 85, 80, 24)];
    [self.titleLabel setFont:UIFontWithSize(12)];
    
    if (index == 0) {
        [self setImg:@"mime_order" andLabel:@"我的订单"];
    }else if (index == 1){
        [self setImg:@"mime_personal" andLabel:@"个人中心"];
    }else if (index == 2){
        [self setImg:@"mime_comment" andLabel:@"我的评价"];
    }
    
    [self addSubview:self.ItemImageView];
    [self addSubview:self.titleLabel];
}

-(void)setImg:(NSString *)imgName andLabel:(NSString *)titleStr{
    self.ItemImageView.image = [UIImage imageNamed:imgName];
    self.titleLabel.text = titleStr;
}

@end
