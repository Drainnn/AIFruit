//
//  AppDelegate.h
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AIFTabBarController.h"
#import "UserInfo.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *searchRecordFilePath;//搜素记录的文件
@property (strong, nonatomic) NSMutableArray *searchRecordArray;//搜索记录的数组

@property (strong, nonatomic) NSMutableArray *shopCarArray;//购物车数组
@property (strong, nonatomic) NSString *shopCarFilePath;//记录购物车的文件

@property (nonatomic, strong) AIFTabBarController *mainTabController;

@property (nonatomic, assign) int isLogin;//用户是否登录
@property (nonatomic, strong) NSDictionary *userInfoDict;//用户信息
@property (nonatomic, copy) NSString *userInfoFilePath;//用户信息保存的文件
@property (nonatomic, strong) UserInfo *userinfo;


@end

