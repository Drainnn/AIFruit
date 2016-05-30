//
//  IFGradeTableViewCell.m
//  iFruit
//
//  Created by administrator on 15/8/13.
//  Copyright (c) 2015年 gem. All rights reserved.
//

#import "IFGradeTableViewCell.h"

@implementation IFGradeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    if (self_screen_width>350) {
        self.ratingView = [[IFRatingView alloc]initWithFrame:CGRectMake(120, 20, 150, 30) numberOfFlower:5];
        [self.ratingView changeFlowerForegroundViewWithPoint:CGPointMake(150, 30)];
    }
    else{
        self.ratingView = [[IFRatingView alloc]initWithFrame:CGRectMake(100, 25, 100, 20) numberOfFlower:5];
        [self.ratingView changeFlowerForegroundViewWithPoint:CGPointMake(100, 20)];
    }
    self.descripeLabel.text = @"描述相符";
    self.scoreLabel.tag = 500;
    [self addSubview:self.ratingView];
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(void)setCellInfo{
//    [self addSubview:self.ratingView];
//}

@end
