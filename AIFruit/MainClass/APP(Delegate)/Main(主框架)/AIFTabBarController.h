//
//  AIFTabBarController.h
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BadgeView.h"

@interface AIFTabBarController : UITabBarController

@property (nonatomic, strong) BadgeView *badgeView;//图标视图

@property (nonatomic, assign) int badgeValue;//图标数字

@property (nonatomic, assign) int totalNum;//总数量

@property (nonatomic, assign) int totalPrice;//总价

@end
