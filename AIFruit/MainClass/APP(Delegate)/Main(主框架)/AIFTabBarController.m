//
//  AIFTabBarController.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "AIFTabBarController.h"
#import "HomeTableViewController.h"
#import "CategoryTableViewController.h"
#import "AppDelegate.h"


@interface AIFTabBarController ()

@property (nonatomic, strong) NSMutableArray *tabBarItems;

@end

@implementation AIFTabBarController

- (NSMutableArray *)tabBarItems{
    
    if (_tabBarItems == nil){
        _tabBarItems = [NSMutableArray array];
    }
    return _tabBarItems;
}

-(BadgeView *)badgeView{
    if (!_badgeView) {
        _badgeView = [[BadgeView alloc]initWithFrame:CGRectMake(self_screen_width*1.0/5*3+45, self_screen_height-44, 18, 18) WithString:@"0"];
        [self.view addSubview:_badgeView];
    }
    return _badgeView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加首页
    UIViewController *homeVC = [[UIStoryboard storyboardWithName:@"HomeController" bundle:nil]instantiateInitialViewController];
    [self addOneChildController:homeVC normalImage:[UIImage imageNamed:@"nav_home"] pressImage:[UIImage imageNamed:@"nav_home_active"] navigationBarTitle:@"首页"];
    
    
    //添加分类页
    UIViewController *categoryVC = [[UIStoryboard storyboardWithName:@"Category" bundle:nil]instantiateInitialViewController];
    [self addOneChildController:categoryVC normalImage:[UIImage imageNamed:@"nav_cate"] pressImage:[UIImage imageNamed:@"nav_cate_active"] navigationBarTitle:@"分类"];
    
    //添加搜索页
    UIViewController *searchVC = [[UIStoryboard storyboardWithName:@"Search" bundle:nil] instantiateInitialViewController];
    [self addOneChildController:searchVC normalImage:[UIImage imageNamed:@"nav_search"] pressImage:[UIImage imageNamed:@"nav_search_active"] navigationBarTitle:@"搜索"];
    
    //添加购物车
    UIViewController *shoppingCarVC = [[UIStoryboard storyboardWithName:@"shoppingCarStoryboard" bundle:nil]instantiateInitialViewController];
    [self addOneChildController:shoppingCarVC normalImage:[UIImage imageNamed:@"nav_cart"] pressImage:[UIImage imageNamed:@"nav_cart_active"] navigationBarTitle:@"购物车"];
    
    
    //添加我的页面
    UIViewController *mineVC = [[UIStoryboard storyboardWithName:@"MineController" bundle:nil] instantiateInitialViewController];
    [self addOneChildController:mineVC normalImage:[UIImage imageNamed:@"nav_usercenter"] pressImage:[UIImage imageNamed:@"nav_usercenter_active"] navigationBarTitle:@"我的"];
    
    //添加登录注册
//    UIViewController *loginRegistVC = [[UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil] instantiateInitialViewController];
//    [self addOneChildController:loginRegistVC normalImage:[UIImage imageNamed:@"nav_search"] pressImage:[UIImage imageNamed:@"nav_search_active"] navigationBarTitle:@"登录"];
    
    UIFont *font = UIFontWithSize(16);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : themeColor,NSFontAttributeName : font}];
     self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    

    
    // UIControlStateSelected情况的文字属性
    NSMutableDictionary *selectedAtrrs = [NSMutableDictionary dictionary];
    // 文字颜色
    selectedAtrrs[NSForegroundColorAttributeName] = themeColor;
    
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:selectedAtrrs forState:UIControlStateSelected];
    
    [self initBadgeViewNum];

}

#pragma mark - 初始化购物车信息的值，数量，总价
-(void)initBadgeViewNum{
    self.totalNum = 0;
    self.totalPrice = 0;
    for (NSMutableDictionary *dic in APPDELEGATE.shopCarArray) {
        int num = [[dic valueForKey:shopCar_Fruit_Num_Key] intValue];
        int price = [[dic valueForKey:shopCar_Fruit_Price_Key]intValue];
        self.totalNum += num;
        self.totalPrice += num*price;
    }
    self.badgeView.badgeValue = self.totalNum;
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

/**
 *  添加单个控制器
 *
 *  @param viewController 子控制器视图
 *  @param normalImage    正常图标
 *  @param pressImage     单击图标
 *  @param title          标题
 */
- (void)addOneChildController:(UIViewController *)viewController normalImage:(UIImage *)normalImage
                   pressImage:(UIImage *)pressImage
                  navigationBarTitle:(NSString *)title{
    
//    viewController.navigationItem.title = title;
    viewController.tabBarItem.image = normalImage;
    viewController.tabBarItem.selectedImage = pressImage;
    viewController.tabBarItem.title = title;
    [self addChildViewController:viewController];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
