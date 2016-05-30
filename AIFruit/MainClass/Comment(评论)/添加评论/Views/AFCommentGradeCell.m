//
//  AFCommentGradeCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "AFCommentGradeCell.h"

@implementation AFCommentGradeCell

- (void)awakeFromNib {
    self.ratingView = [[IFRatingView alloc]initWithFrame:CGRectMake(100, 25, 100, 20) numberOfFlower:5];
    [self.ratingView changeFlowerForegroundViewWithPoint:CGPointMake(100, 20)];
    [self addSubview:self.ratingView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
