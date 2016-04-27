//
//  shopCarBottomView.h
//  AIFruit
//
//  Created by Kosne on 16/4/21.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ToOrderVC)();

@interface shopCarBottomView : UIView

@property (nonatomic, strong) UILabel *l1;
@property (nonatomic, strong) UILabel *l2;
@property (nonatomic, strong) UILabel *l3;
@property (nonatomic, strong) UILabel *l4;
@property (nonatomic, strong) UIButton *btn;

-(instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, copy) ToOrderVC toOrderVC;

@end
