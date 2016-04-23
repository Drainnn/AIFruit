//
//  BadgeView.h
//  AIFruit
//
//  Created by Kosne on 16/4/20.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeView : UIView

@property (nonatomic, copy) NSString *badgeStr;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, assign) int badgeValue;

-(instancetype)initWithFrame:(CGRect)frame WithString:(NSString *)string;

@end
