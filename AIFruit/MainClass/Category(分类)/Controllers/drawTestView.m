//
//  drawTestView.m
//  AIFruit
//
//  Created by Kosne on 16/4/6.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "drawTestView.h"

@implementation drawTestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)setupView{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
    [btn setTitle:@"郑慧祯" forState:UIControlStateNormal];
    [btn setTitleColor:themeColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

-(void)action:(id)sender{
    NSLog(@"zhz");
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

@end
