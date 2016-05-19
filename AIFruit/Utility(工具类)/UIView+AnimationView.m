//
//  UIView+AnimationView.m
//  AIFruit
//
//  Created by Kosne on 16/4/28.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "UIView+AnimationView.h"
#import "AppDelegate.h"

@implementation UIView (AnimationView)

+(void)hideTabbarWithAnimation:(UITabBarController *)tabbarController{
    [UIView animateWithDuration:0.5 animations:^{
        tabbarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
        APPDELEGATE.mainTabController.badgeView.transform = CGAffineTransformMakeTranslation(0, 49);
    }];
}

+(void)showNormalTabbarWithNoAnimation:(UITabBarController *)tabbarController{
    tabbarController.tabBar.transform = CGAffineTransformIdentity;
    APPDELEGATE.mainTabController.badgeView.transform = CGAffineTransformIdentity;
}

@end
