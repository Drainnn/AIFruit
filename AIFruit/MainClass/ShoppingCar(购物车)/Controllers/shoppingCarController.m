//
//  shoppingCarController.m
//  AIFruit
//
//  Created by Kosne on 16/4/18.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "shoppingCarController.h"
#import "BadgeView.h"
#import "shopCarInfoCell.h"
#import "AppDelegate.h"
#import "shopCarBottomView.h"
#import "orderViewController.h"
#import "shopCarEmptyView.h"
#import "UIView+AnimationView.h"
#import "LoginAndRegisterViewController.h"

@interface shoppingCarController ()<UITableViewDataSource,UITableViewDelegate>{
    int flag;
}

@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) shopCarBottomView *bottomView;
@property (nonatomic, strong) shopCarEmptyView *emptyView;
@end

@implementation shoppingCarController

-(shopCarBottomView *)bottomView{
    if (!_bottomView) {
        shopCarBottomView *bottomView = [[shopCarBottomView alloc]initWithFrame:CGRectMake(-0.5, self_screen_height-49-60, self_screen_width+1, 60)];
        _bottomView = bottomView;
        __weak shoppingCarController *weakSelf = self;
        _bottomView.toOrderVC = ^(){
            [weakSelf toOrderView];
        };
    }
    return _bottomView;
}

-(shopCarEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[shopCarEmptyView alloc]initWithFrame:self.view.bounds];
        __weak shoppingCarController *weakSelf = self;
        _emptyView.toMainView = ^(){
            [weakSelf toMainView];
        };
    }
    return _emptyView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化标志为0
    flag = 0;
    
    UIFont *font = UIFontWithSize(16);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : themeColor,NSFontAttributeName : font}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self initTableView];
    
    if (APPDELEGATE.mainTabController.totalNum == 0) {
        [self.view addSubview:self.emptyView];
    }else{
        [self.view addSubview:self.bottomView];
    }
    
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didNotice:) name:numChangeFromFruitList object:nil];
    [center addObserver:self selector:@selector(didNotice:) name:numChangeFromDetail object:nil];
    [center addObserver:self selector:@selector(didNotice:) name:orderpopToshopcar object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (flag) {
        //移动tabbar到正常位置
        [UIView showNormalTabbarWithNoAnimation:self.tabBarController];
        //重新设置flag为0;
        flag = 0;
    }
    
}
#pragma mark - 接收到其他地方修改购物车的数量值改变后的响应事件,刷新视图
-(void)didNotice:(id)sender{
    [self.dataTableView reloadData];
    if (APPDELEGATE.mainTabController.totalNum > 0) {
        [self.view addSubview:self.bottomView];
        [self.emptyView removeFromSuperview];
    }else{
        [self.view addSubview:self.emptyView];
        [self.bottomView removeFromSuperview];
    }
}


-(void)initTableView{
    CGRect rect = self.view.bounds;
    rect.size.height -= 60;
    UITableView *tableView = [[UITableView alloc]initWithFrame:rect];
    _dataTableView = tableView;
    _dataTableView.delegate = self;
    _dataTableView.dataSource = self;
    _dataTableView.rowHeight = 80;
    _dataTableView.tableFooterView = [UIView new];
    [self.view addSubview:_dataTableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return APPDELEGATE.shopCarArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"shopCarInfoCell";
    shopCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"shopCarInfoCell" owner:nil options:nil]firstObject];
    }
    NSMutableDictionary *dict = APPDELEGATE.shopCarArray[indexPath.row];
    cell.dict = dict;
    cell.index = indexPath.row;
    [cell setupCell];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableDictionary *dict = APPDELEGATE.shopCarArray[indexPath.row];
        int num = [[dict valueForKey:shopCar_Fruit_Num_Key]intValue];
        int price = [[dict valueForKey:shopCar_Fruit_Price_Key]intValue];
        APPDELEGATE.mainTabController.totalNum -= num;
        APPDELEGATE.mainTabController.badgeView.badgeValue = APPDELEGATE.mainTabController.totalNum;
        APPDELEGATE.mainTabController.totalPrice -= (num*price);
        
        //更新bottomView的总量值，价格值
        self.bottomView.l2.text = [NSString stringWithFormat:@"%d",APPDELEGATE.mainTabController.totalNum];
        self.bottomView.l4.text = [NSString stringWithFormat:@"￥%d",APPDELEGATE.mainTabController.totalPrice];
        
        [APPDELEGATE.shopCarArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [APPDELEGATE.shopCarArray writeToFile:APPDELEGATE.shopCarFilePath atomically:YES];
        [self.dataTableView reloadData];
        //如果购物车数量为0 移除底部视图
        if (APPDELEGATE.mainTabController.totalNum == 0 ) {
            [self.bottomView removeFromSuperview];
            [self performSelector:@selector(justAddBottomView) withObject:nil afterDelay:0.5];
        }
    }
}

-(void)justAddBottomView{
    [self.view addSubview:self.emptyView];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

#pragma mark - Push订单页面
-(void)toOrderView{
    [UIView hideTabbarWithAnimation:self.tabBarController];
    //标志设为1
    flag = 1;
    if (APPDELEGATE.isLogin) {
        orderViewController *orderVC = [[UIStoryboard storyboardWithName:@"orderView" bundle:nil]instantiateInitialViewController];
        [self.navigationController pushViewController:orderVC animated:YES];
    }else{
        LoginAndRegisterViewController *loginAndRegisterVC = [[UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil] instantiateInitialViewController];
        [self.navigationController pushViewController:loginAndRegisterVC animated:YES];
        //    [self presentViewController:loginAndRegisterVC animated:YES completion:nil];
    }
    

        [UIView hideTabbarWithAnimation:self.tabBarController];
        
    
}

#pragma mark - 到首页
-(void)toMainView{
    APPDELEGATE.mainTabController.selectedIndex = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:numChangeFromFruitList object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:numChangeFromDetail object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:numChangeFromBtn object:nil];
}


@end
