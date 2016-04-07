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

-(void)drawTrianglePath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 20)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - 40, 20)];
    [path addLineToPoint:CGPointMake(self.frame.size.width / 2, self.frame.size.height)];
    
    [path closePath];
    
    path.lineWidth = 1.5;
    
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    
    UIColor *stokeColor = [UIColor blueColor];
    [stokeColor set];
    
    [path stroke];
}

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

@end
