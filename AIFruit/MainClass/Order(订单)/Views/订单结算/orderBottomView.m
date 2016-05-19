//
//  orderBottomView.m
//  AIFruit
//
//  Created by Kosne on 16/4/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "orderBottomView.h"
#import "AppDelegate.h"

@implementation orderBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *l1 = [[UILabel alloc]initWithFrame:CGRectMake(7, 19, 85, 21)];
        _yingfujine = l1;
        _yingfujine.text = @"应付金额:";
        
        UILabel *l2 = [[UILabel alloc]initWithFrame:CGRectMake(92, 20, 95, 21)];
        _priceLabel = l2;
        _priceLabel.text = [NSString stringWithFormat:@"￥%d.00",APPDELEGATE.mainTabController.totalPrice+10];
        _priceLabel.textColor = fruit_red;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(192, 9, 120, 42)];
        _submitBtn = btn;
        [_submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitBtn.titleLabel setFont:UIFontWithSize(14)];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:fruit_red];
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self_screen_width, 0.5)];
        [label setBackgroundColor:[UIColor grayColor]];
        
        [self addSubview:_priceLabel];
        [self addSubview:_yingfujine];
        [self addSubview:_submitBtn];
        [self addSubview:label];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(void)action:(UIButton *)btn{
    _didsubmitBtn();
}


@end
