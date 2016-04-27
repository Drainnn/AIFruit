//
//  AppDelegate.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "AppDelegate.h"

#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface AppDelegate ()


@end



@implementation AppDelegate


//-(AIFTabBarController *)mainTabController{
//    if (_mainTabController) {
//        _mainTabController = [[AIFTabBarController alloc]init];
//    }
//    return _mainTabController;
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    CGRect rect = [[UIScreen mainScreen]bounds];
    self.window = [[UIWindow alloc]initWithFrame:rect];
    
    [self loadSearchRecordFromFilePath];
    [self loadshopCarFromFilePath];
    [self loaduserInfoFromFilePath];
    
    self.mainTabController = [[AIFTabBarController alloc]init];
    self.window.rootViewController = self.mainTabController;
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 读取搜索记录
-(void)loadSearchRecordFromFilePath
{
    //获取文件路径
    NSArray *doucumentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *DocumentPath = [doucumentPaths objectAtIndex:0];
    _searchRecordFilePath = [NSString stringWithFormat:@"%@/record.plist",DocumentPath];
    
    //判断文件路径是否存在
    NSFileManager *mangager = [NSFileManager defaultManager];
    if ([mangager fileExistsAtPath:_searchRecordFilePath]) {
        _searchRecordArray = [NSMutableArray arrayWithContentsOfFile:_searchRecordFilePath];
    }
    else{
        _searchRecordArray = [NSMutableArray array];
    }
}

#pragma mark - 读取购物车记录
-(void)loadshopCarFromFilePath
{
    //获取文件路径
    NSArray *doucumentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *DocumentPath = [doucumentPaths objectAtIndex:0];
    _shopCarFilePath = [NSString stringWithFormat:@"%@/shopCar.plist",DocumentPath];
    NSLog(@"%@",DocumentPath);
    //判断文件路径是否存在
    NSFileManager *mangager = [NSFileManager defaultManager];
    if ([mangager fileExistsAtPath:_shopCarFilePath]) {
        _shopCarArray = [NSMutableArray arrayWithContentsOfFile:_shopCarFilePath];
    }
    else{
        _shopCarArray = [NSMutableArray array];
    }
}

#pragma mark - 读取用户信息
-(void)loaduserInfoFromFilePath
{
    //获取文件路径
    NSArray *doucumentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *DocumentPath = [doucumentPaths objectAtIndex:0];
    _userInfoFilePath = [NSString stringWithFormat:@"%@/userinfo.plist",DocumentPath];
    
    //判断文件路径是否存在
    NSFileManager *mangager = [NSFileManager defaultManager];
    if ([mangager fileExistsAtPath:_userInfoFilePath]) {
        _userInfoDict = [NSDictionary dictionaryWithContentsOfFile:_userInfoFilePath];
        _isLogin = 1;
        NSData *data = [[NSData alloc]initWithContentsOfFile:_userInfoFilePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        _userinfo = [unarchiver decodeObjectForKey:@"user"];
    }
    else{
        
        _userInfoDict = [NSDictionary dictionary];
        _isLogin = 0;
    }
}



-(NSString *)SetFilePath{
    NSString *rootPath = NSHomeDirectory();
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/user.plist",rootPath];
    return filePath;
}

@end
