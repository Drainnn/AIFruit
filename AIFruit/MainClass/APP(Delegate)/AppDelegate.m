//
//  AppDelegate.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "AppDelegate.h"
#import "AIFTabBarController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    CGRect rect = [[UIScreen mainScreen]bounds];
    self.window = [[UIWindow alloc]initWithFrame:rect];
    
    AIFTabBarController *mainTabController = [[AIFTabBarController alloc]init];
    self.window.rootViewController = mainTabController;
    
    double test = 1.0 * 4 / 7;
    NSLog(@"%.2f",test);
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
    NSLog(@"document:%@",DocumentPath);
    
    //判断文件路径是否存在
    NSFileManager *mangager = [NSFileManager defaultManager];
    if ([mangager fileExistsAtPath:_searchRecordFilePath]) {
        _searchRecordDict = [NSMutableDictionary dictionaryWithContentsOfFile:_searchRecordFilePath];
    }
    else{
        _searchRecordDict = [NSMutableDictionary dictionary];
    }
}


-(NSString *)SetFilePath{
    NSString *rootPath = NSHomeDirectory();
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/user.plist",rootPath];
    return filePath;
}

@end
