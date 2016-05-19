//
//  orderBottomView.h
//  AIFruit
//
//  Created by Kosne on 16/4/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidsubmitBtn)();

@interface orderBottomView : UIView

@property (nonatomic, strong) UILabel *yingfujine;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, copy) DidsubmitBtn didsubmitBtn;

-(instancetype)initWithFrame:(CGRect)frame;

@end
