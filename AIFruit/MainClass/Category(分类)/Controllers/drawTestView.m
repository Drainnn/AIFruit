//
//  drawTestView.m
//  AIFruit
//
//  Created by Kosne on 16/4/6.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "drawTestView.h"

#define btn_height 45
#define btn_width self_screen_width/2
#define bottom_view_height 0.5

@implementation drawTestView
{
    UIFont *font;
    CGRect btn_frame;
    CGRect bottom_frame;
}



-(void)setupViewWithArray:(NSArray *)cateNameArr{
    NSInteger arrCount = cateNameArr.count;
    for (int i = 1; i <= arrCount; i ++) {
        NSString *title = cateNameArr[i-1];
        
        if (i%2) {
            int level = i/2;
            btn_frame = CGRectMake(0, level*btn_height, btn_width, btn_height);
            bottom_frame = CGRectMake(0, (level+1)*btn_height, btn_width, bottom_view_height);
            
        }else{
            int level = i/2-1;
            btn_frame = CGRectMake(btn_width, level*btn_height, btn_width, btn_height);
            bottom_frame = CGRectMake(btn_width, (level+1)*btn_height, btn_width, bottom_view_height);
        }
        [self setupItemWithFrame:btn_frame andTitle:title andBottomFrame:bottom_frame];
    }
    
}

-(void)setupItemWithFrame:(CGRect)btnframe  andTitle:(NSString *)title andBottomFrame:(CGRect)bottomframe{
    UIButton *btn = [[UIButton alloc]initWithFrame:btnframe];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:themeColor forState:UIControlStateNormal];
    [btn.titleLabel setFont:font];
    UIView *bottomV = [[UIView alloc]initWithFrame:bottomframe];
    [bottomV setBackgroundColor:[UIColor grayColor]];
    [self addSubview:btn];
    [self addSubview:bottomV];
}

-(void)action:(id)sender{
    NSLog(@"zhz");
}

-(instancetype)initWithFrame:(CGRect)frame andCount:(NSInteger)count{
    CGFloat self_view_height = (count/2+1)*btn_height;
    CGRect self_frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, self_view_height);
    if (self = [super initWithFrame:self_frame]) {
        font = UIFontWithSize(14);
//        [self setupView];
    }
    return self;
}

@end
