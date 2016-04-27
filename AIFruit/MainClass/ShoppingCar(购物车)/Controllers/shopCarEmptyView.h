//
//  shopCarEmptyView.h
//  AIFruit
//
//  Created by Kosne on 16/4/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ToMainView)();

@interface shopCarEmptyView : UIView

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *toMainBtn;

@property (nonatomic, copy) ToMainView toMainView;

-(instancetype)initWithFrame:(CGRect)frame;

@end
