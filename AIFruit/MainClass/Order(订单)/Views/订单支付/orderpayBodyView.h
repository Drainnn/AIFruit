//
//  orderpayBodyView.h
//  AIFruit
//
//  Created by Kosne on 16/4/28.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderpayBodyView : UIView


@property (nonatomic, strong) UILabel *orderNoTitleLabel;//订单编号标题
@property (nonatomic, strong) UILabel *orderNoLabel;//订单编号
@property (nonatomic, strong) UILabel *payTitleLabel;//应付金额
@property (nonatomic, strong) UILabel *payLabel;
@property (nonatomic, strong) UILabel *payWayTitleLabel;//支付方式标题
@property (nonatomic, strong) UILabel *payWayLabel;
@property (nonatomic, strong) UIButton *detailBtn;//详情按钮
@property (nonatomic, strong) UILabel *sendTimeTitleALabel;
@property (nonatomic, strong) UILabel *sendTimeTitleBLabel;
@property (nonatomic, strong) UILabel *sendTimeLabel;



-(instancetype)initWithFrame:(CGRect)frame;
-(void)setupViewWithDict:(NSMutableDictionary *)dict;

@end
