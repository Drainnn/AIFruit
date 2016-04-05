//
//  AppDelegate.h
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) NSMutableDictionary *searchRecordDict;//搜索记录的字典
@property (strong, nonatomic) NSString *searchRecordFilePath;//搜素记录的文件

@end

