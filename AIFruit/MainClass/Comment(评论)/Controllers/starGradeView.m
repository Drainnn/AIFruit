//
//  starGradeView.m
//  AIFruit
//
//  Created by Kosne on 16/4/18.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "starGradeView.h"

@implementation starGradeView

-(instancetype)initWithFrame:(CGRect)frame andGrade:(int)grade andWidth:(CGFloat)starwidth andSpace:(CGFloat)space{
    if (self = [super initWithFrame:frame]) {
        CGFloat starheight = frame.size.height;
        for (int i = 0; i < 5; i++) {
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*(starwidth+space), 0, starwidth, starheight)];
            
            if (i < grade) {
                [imgView setImage:[UIImage imageNamed:@"starlight"]];
            }
            else{
                [imgView setImage:[UIImage imageNamed:@"stardefault"]];
            }
            [self addSubview:imgView];
        }
    }
    return self;
}


@end
