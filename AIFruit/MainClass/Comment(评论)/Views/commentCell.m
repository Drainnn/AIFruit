//
//  commentCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "commentCell.h"
#import "starGradeView.h"

@implementation commentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithComment:(Comment *)comment{
    self.mobileNoLabel.text = comment.mobileNo;
    self.pushTimeLabel.text = comment.pushTime;
    self.contLabel.text = comment.content;
    starGradeView *view = [[starGradeView alloc]initWithFrame:CGRectMake(16, 31, starView_Width, starView_Heigth) andGrade:comment.score andWidth:star_Width andSpace:star_Space];
    [self addSubview:view];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, UIColorWithRGBA(237, 237, 237, 1.0f).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}

@end
