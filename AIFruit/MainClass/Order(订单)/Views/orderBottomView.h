//
//  orderBottomView.h
//  AIFruit
//
//  Created by Kosne on 16/4/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderBottomView : UIView

@property (nonatomic, strong) UILabel *yingfujine;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *submitBtn;

-(instancetype)initWithFrame:(CGRect)frame;

@end
