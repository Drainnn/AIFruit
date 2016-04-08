//
//  categorySegment.m
//  AIFruit
//
//  Created by Kosne on 16/4/7.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "categorySegment.h"

@implementation categorySegment
{
    NSInteger currentItem;//当前选中项
    UIView *btnBottom;//按钮底部下划线
    NSMutableArray *TitleBtnArray;//存放按钮的数组
    float btnWidth;//按钮的宽度
    UIColor *defaultColor;//默认按钮颜色
    UIColor *selectColor;//选中按钮颜色
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    defaultColor = UIColorWithRGBA(209, 209, 209, 1.0f);
    selectColor = themeColor;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColorWithRGBA(196, 196, 196, 1.0f) CGColor];
    return self;
}

-(void)addTitleBtnWithTitleArray:(NSArray *)titleArr{
    NSInteger length = titleArr.count;
    TitleBtnArray = [[NSMutableArray alloc]initWithCapacity:length];
    btnWidth = self_screen_width/length;
    for (int i = 0; i < length; i++){
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*(self_screen_width/length), 0, btnWidth, categorySegmentHeight-2)];
        [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        if (i == 0) {
            [btn setTitleColor:selectColor forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:defaultColor forState:UIControlStateNormal];
        }
        UIFont *font = UIFontWithSize(15);
        [btn.titleLabel setFont:font];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i];
        [self addSubview:btn];
        [TitleBtnArray addObject:btn];
    }
    currentItem = 0;
    [self initBtnBottomView];
}

-(void)initBtnBottomView{
    btnBottom = [[UIView alloc]initWithFrame:CGRectMake(20, categorySegmentHeight-2, 70, 2)];
    [btnBottom setBackgroundColor:themeColor];
    [self addSubview:btnBottom];
}

-(void)action:(UIButton *)sender{
    [self changeSelectItemWithIndex:sender.tag];
}

-(void)changeSelectItemWithIndex:(NSInteger)index{
    if (currentItem != index) {
        UIButton *nbtn = [TitleBtnArray objectAtIndex:index];
        [nbtn setTitleColor:selectColor forState:UIControlStateNormal];
        UIButton *obtn = [TitleBtnArray objectAtIndex:currentItem];
        [obtn setTitleColor:defaultColor forState:UIControlStateNormal];
        [UIView animateWithDuration:0.1 animations:^{
            btnBottom.frame = CGRectMake(index*btnWidth+20, categorySegmentHeight-2, 70, 2);
        }];
        currentItem = index;
    }
    
}

@end
