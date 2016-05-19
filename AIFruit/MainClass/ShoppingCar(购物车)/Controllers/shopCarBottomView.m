//
//  shopCarBottomView.m
//  AIFruit
//
//  Created by Kosne on 16/4/21.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "shopCarBottomView.h"
#import "AppDelegate.h"

@implementation shopCarBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *l1 = [[UILabel alloc]initWithFrame:CGRectMake(13, 8, 30, 21)];
        _l1 = l1;
        l1.text = @"数量:";
        [l1 setFont:UIFontWithSize(11)];
        
        
        UILabel *l2 = [[UILabel alloc]initWithFrame:CGRectMake(44, 8, 24, 21)];
        _l2 = l2;
        l2.text = [NSString stringWithFormat:@"%d",APPDELEGATE.mainTabController.totalNum];
        [l2 setFont:UIFontWithSize(14)];
        
        
        UILabel *l3 = [[UILabel alloc]initWithFrame:CGRectMake(13, 30, 64, 21)];
        _l3 = l3;
        l3.text = @"商品总额:";
        [l3 setFont:UIFontWithSize(14)];
        
        UILabel *l4 = [[UILabel alloc]initWithFrame:CGRectMake(79, 30, 58, 21)];
        _l4 = l4;
        l4.text = [NSString stringWithFormat:@"￥%d",APPDELEGATE.mainTabController.totalPrice];
        [l4 setFont:UIFontWithSize(14)];
        [l4 setTextColor:fruit_red];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(198, 8, 114, 43)];

        [btn setTitle:@"去结算" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:UIColorWithRGB(255, 107, 107)];
        btn.layer.cornerRadius = 5.0f;
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        _btn = btn;
        
        [self addSubview:_l1];
        [self addSubview:_l2];
        [self addSubview:_l3];
        [self addSubview:_l4];
        [self addSubview:_btn];
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        
        //接收通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeNum:) name:numChangeFromBtn object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeNum:) name:numChangeFromFruitList object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeNum:) name:numChangeFromDetail object:nil];
    }
    return self;
}

#pragma mark - 接收到通知后的事件
-(void)changeNum:(NSNotification *)notification{
    _l2.text = [NSString stringWithFormat:@"%d",APPDELEGATE.mainTabController.totalNum];
    _l4.text = [NSString stringWithFormat:@"￥%d",APPDELEGATE.mainTabController.totalPrice];
}

//按钮事件
-(void)action:(UIButton *)btn{
    _toOrderVC();
}

-(void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:numChangeFromBtn object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:numChangeFromFruitList object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:numChangeFromDetail object:nil];
}

@end
