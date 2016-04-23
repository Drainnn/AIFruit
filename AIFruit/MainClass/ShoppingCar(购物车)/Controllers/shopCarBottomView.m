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
//        
//        CGFloat width = frame.size.width;
//        CGFloat height = frame.size.height;
        
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
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(198, 8, 114, 43)];
        _btn = btn;
        [btn setTitle:@"去结算" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:UIColorWithRGB(255, 107, 107)];
        btn.layer.cornerRadius = 5.0f;
        
        [self addSubview:_l1];
        [self addSubview:_l2];
        [self addSubview:_l3];
        [self addSubview:_l4];
        [self addSubview:_btn];
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        
        //接收通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeNumFromBtn:) name:numChangeFromBtn object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeNumFromFruitList:) name:numChangeFromFruitList object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeNumFromDetail:) name:numChangeFromDetail object:nil];
    }
    return self;
}

-(void)changeNumFromBtn:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    _l2.text = [dict valueForKey:@"totalNum"];
    _l4.text = [dict valueForKey:@"totalPrice"];
}

-(void)changeNumFromFruitList:(NSNotification *)notification{
    _l2.text = [NSString stringWithFormat:@"%d",APPDELEGATE.mainTabController.totalNum];
    _l4.text = [NSString stringWithFormat:@"￥%d",APPDELEGATE.mainTabController.totalPrice];
}

-(void)changeNumFromDetail:(NSNotification *)notification{
    _l2.text = [NSString stringWithFormat:@"%d",APPDELEGATE.mainTabController.totalNum];
    _l4.text = [NSString stringWithFormat:@"￥%d",APPDELEGATE.mainTabController.totalPrice];
}

-(void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:numChangeFromBtn object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:numChangeFromFruitList object:nil];
}

@end
