//
//  UIView+AnimationView.h
//  AIFruit
//
//  Created by Kosne on 16/4/28.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AnimationView)

+(void)hideTabbarWithAnimation:(UITabBarController *)tabbarController;

+(void)showNormalTabbarWithNoAnimation:(UITabBarController *)tabbarController;

@end
