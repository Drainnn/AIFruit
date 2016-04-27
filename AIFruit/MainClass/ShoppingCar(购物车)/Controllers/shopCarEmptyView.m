//
//  shopCarEmptyView.m
//  AIFruit
//
//  Created by Kosne on 16/4/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "shopCarEmptyView.h"

@implementation shopCarEmptyView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGPoint selfCenter = self.center;
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        self.imgView.center = CGPointMake(selfCenter.x, selfCenter.y-50);
        [self.imgView setImage:[UIImage imageNamed:@"emptyShopCar"]];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
        self.titleLabel.center = CGPointMake(selfCenter.x+5, selfCenter.y);
        self.titleLabel.text = @"购物车是空的";
        [self.titleLabel setFont:UIFontWithSize(12)];
        [self.titleLabel setTextColor:UIColorWithRGB(217, 217, 217)];
        
        self.toMainBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
        [self.toMainBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
        [self.toMainBtn setTitleColor:themeColor forState:UIControlStateNormal];
        [self.toMainBtn.titleLabel setFont:UIFontWithSize(15)];
        self.toMainBtn.layer.borderWidth = 0.5;
        self.toMainBtn.layer.borderColor = themeColor.CGColor;
        self.toMainBtn.layer.cornerRadius = 5;
        self.toMainBtn.center = CGPointMake(selfCenter.x+2, selfCenter.y+40);
        [self.toMainBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside ];
        
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.toMainBtn];
    }
    return self;
}

-(void)action:(UIButton *)sender{
    _toMainView();
}


@end
