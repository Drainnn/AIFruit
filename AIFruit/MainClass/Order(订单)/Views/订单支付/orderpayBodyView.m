//
//  orderpayBodyView.m
//  AIFruit
//
//  Created by Kosne on 16/4/28.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "orderpayBodyView.h"

@implementation orderpayBodyView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = border_color_gray.CGColor;
        [self setBackgroundColor:[UIColor whiteColor]];
        
        
    }
    return self;
}

-(void)setupViewWithDict:(NSMutableDictionary *)dict{
    
    self.orderNoTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 11, 68, 20)];
    [self.orderNoTitleLabel setFont:UIFontWithSize(14)];
    self.orderNoTitleLabel.text = @"订单编号:";
    
    self.orderNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 11, 130, 20)];
    [self.orderNoLabel setFont:UIFontWithSize(14)];
    self.orderNoLabel.text = dict[@"orderNO"];
    
    self.payTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 36, 68, 20)];
    self.payTitleLabel.text = @"应付金额:";
    [self.payTitleLabel setFont:UIFontWithSize(14)];
    
    self.payLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 36, 134, 20)];
    [self.payLabel setFont:UIFontWithSize(14)];
    [self.payLabel setTextColor:fruit_red];
    self.payLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"totalPrice"]];
    
    self.payWayTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 63, 68, 20)];
    self.payWayTitleLabel.text = @"支付方式:";
    [self.payWayTitleLabel setFont:UIFontWithSize(14)];
    
    self.payWayLabel = [[UILabel alloc]initWithFrame:CGRectMake(92, 63, 118, 20)];
    self.payWayLabel.text = @"支付宝方式";
    [self.payWayLabel setFont:UIFontWithSize(14)];
    
    self.detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(195, 32, 87, 35)];
    [self.detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [self.detailBtn setTitleColor:themeColor forState:UIControlStateNormal];
    self.detailBtn.layer.borderColor = border_color_gray.CGColor;
    self.detailBtn.layer.borderWidth = 1;
    self.detailBtn.layer.cornerRadius = 5;
    [self.detailBtn.titleLabel setFont:UIFontWithSize(14)];
    
    UILabel *centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 100, 268, 0.5)];
    [centerLabel setBackgroundColor:border_color_gray];
    
    self.sendTimeTitleALabel = [[UILabel alloc]initWithFrame:CGRectMake(17, 130, 102, 20)];
    self.sendTimeTitleALabel.text = @"预计配送时间";
    [self.sendTimeTitleALabel setFont:UIFontWithSize(17)];
    
    self.sendTimeTitleBLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 159, 137, 21)];
    self.sendTimeTitleBLabel.text = @"请以实际配送时间为准";
    [self.sendTimeTitleBLabel setFont:UIFontWithSize(13)];
    [self.sendTimeTitleBLabel setTextColor:border_color_gray];
    
    self.sendTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(163, 132, 169, 40)];
    self.sendTimeLabel.text = @"2016-04-29";
    [self.sendTimeLabel setFont:UIFontWithSize(22)];
    [self.sendTimeLabel setTextColor:themeColor];
    
    [self addSubview:centerLabel];
    [self addSubview:self.payLabel];
    [self addSubview:self.payTitleLabel];
    [self addSubview:self.payWayLabel];
    [self addSubview:self.payWayTitleLabel];
    [self addSubview:self.orderNoLabel];
    [self addSubview:self.orderNoTitleLabel];
    [self addSubview:self.detailBtn];
    [self addSubview:self.sendTimeTitleALabel];
    [self addSubview:self.sendTimeTitleBLabel];
    [self addSubview:self.sendTimeLabel];
}

@end
