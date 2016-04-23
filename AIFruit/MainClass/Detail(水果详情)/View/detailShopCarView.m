//
//  detailShopCarView.m
//  AIFruit
//
//  Created by Kosne on 16/4/22.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "detailShopCarView.h"
#import "ThrowLineTool.h"
#import "AppDelegate.h"

@interface detailShopCarView ()<ThrowLineToolDelegate>


@end

@implementation detailShopCarView





-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        self.layer.cornerRadius = width/2;
        CGFloat btnX = width/2;
        CGFloat btnY = height/2;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 26, 26)];
        btn.center = CGPointMake(btnX, btnY);
        btn.layer.cornerRadius = width/2;
        [btn setBackgroundImage:[UIImage imageNamed:@"detailShopCar"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self setBackgroundColor:UIColorWithRGBA(232, 30, 12, 0.7)];
        [self addSubview:btn];
    }
    return self;
}

-(void)action:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(didClickShopCar)]) {
        [self.delegate didClickShopCar];
    }
}

-(void)animationDidFinish{
//    APPDELEGATE.mainTabController.badgeView.badgeValue = APPDELEGATE.mainTabController.totalNum;
}

@end
