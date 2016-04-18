//
//  commentTopView.m
//  AIFruit
//
//  Created by Kosne on 16/4/18.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "commentTopView.h"

@implementation commentTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame andScore:(double)score andGreatComment:(double)greatComment{
    if (self = [super initWithFrame:frame]) {
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(12, 7, 70, 20)];
        _label.text = @"总体满意度";
        UIFont *font = UIFontWithSize(12);
        [_label setFont:font];
        [_label setTextColor:[UIColor grayColor]];
        [self addSubview:_label];
        
        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 28, 50, 24)];
        NSString *scoreStr = [NSString stringWithFormat:@"%.1f分",score];
        UIFont *scoreFont = UIFontWithSize(10);
        NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc]initWithString:scoreStr];
        [mutableStr addAttribute:NSFontAttributeName value:scoreFont range:NSMakeRange(scoreStr.length - 1, 1)];
        _scoreLabel.attributedText = mutableStr;
        [_scoreLabel setTextColor:fruit_red];
        [self addSubview:_scoreLabel];
        
        _gradeView = [[starGradeView alloc]initWithFrame:CGRectMake(80, 19, starView_Width, starView_Heigth) andGrade:4 andWidth:star_Width andSpace:star_Space];
        [self addSubview:_gradeView];
        
        _greatComment = [[UILabel alloc]initWithFrame:CGRectMake(245, 19, 70, 20)];
        NSString *str = [NSString stringWithFormat:@"%.2f",greatComment];
        NSString *subStr = [str substringWithRange:NSMakeRange(str.length - 2, 2)];
        NSString *setStr = [NSString stringWithFormat:@"%@%%好评",subStr];
        NSMutableAttributedString *greatCommentStr = [[NSMutableAttributedString alloc]initWithString:setStr];
        [greatCommentStr addAttribute:NSForegroundColorAttributeName value:fruit_red range:NSMakeRange(0, 3)];
        _greatComment.attributedText = greatCommentStr;
        [_greatComment setFont:font];
        [self addSubview:_greatComment];
        
        [self setBackgroundColor:UIColorWithRGB(233, 234, 237)  ];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor grayColor]CGColor];
        
    }
    return self;
}

@end
