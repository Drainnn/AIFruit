//
//  MineController.m
//  AIFruit
//
//  Created by Kosne on 16/4/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "MineController.h"
#import <CoreLocation/CoreLocation.h>
#import "orderCollectionCell.h"
#import "userHeadInfoCell.h"
#import "accountInfoCell.h"
#import "mimeCollectionCell.h"
#import "mimeItemCell.h"
#import "PersonalViewController.h"
#import "LoginAndRegisterViewController.h"
#import "AppDelegate.h"
#import "loginUserHeadInfoCell.h"
#import "MyAddressController.h"
#import "UIView+AnimationView.h"
#import "myOrderController.h"
#import "waitPayTableController.h"
#import "MyCommentController.h"

@interface MineController ()<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    CLLocationManager *location;
    int isLoginView;
    int flag;
}

@property (nonatomic, strong) UICollectionView *dataCollectionView;

@property (nonatomic, strong) UITableView *dataTableView;


@end

NSString *identifier = @"collectionCell";

@implementation MineController

-(UITableView *)dataTableView{
    if (!_dataTableView) {
        CGRect rect = self.view.bounds;
        rect.size.height -= 49;
        _dataTableView = [[UITableView alloc]initWithFrame:rect];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.tableFooterView = [UIView new];
        _dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_dataTableView setBackgroundColor:UIColorWithRGB(247, 255, 255)];
    }
    return _dataTableView;
}


-(UICollectionView *)dataCollectionView{
    if (!_dataCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _dataCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        [_dataCollectionView setBackgroundColor:[UIColor whiteColor]];
//        _dataCollectionView.delegate = self;
//        _dataCollectionView.dataSource = self;
        [_dataCollectionView registerClass:[orderCollectionCell class] forCellWithReuseIdentifier:@"orderCollectionCell"];
    }
    return _dataCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isLoginView = 0;
    flag = 0;
    
    UIFont *font = UIFontWithSize(16);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : themeColor,NSFontAttributeName : font}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    //接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess:) name:loginSuccessNotification object:nil];
    
    [self.view addSubview:self.dataTableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (isLoginView) {
        [self.dataTableView reloadData];
        isLoginView = 0;
    }
    
    if (flag) {
        [UIView showNormalTabbarWithNoAnimation:self.tabBarController];
        flag = 0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 135;
    }else if(indexPath.row == 1){
        return 50;
    }else{
        return 220;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *identifier = @"userHeadInfoCell";
        userHeadInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        [cell setupInfoCell];
        if (!APPDELEGATE.isLogin) {
            __weak MineController *weakSelf = self;
            cell.tologinView = ^(){
                [weakSelf toLoginView];
            };
        }
        
        return cell;
        
    }else if(indexPath.row == 1){
        static NSString *identifier = @"accountInfoCell";
        accountInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupCell];
        return cell;
    }else if(indexPath.row == 2){
        static NSString *identifier = @"mimeCollectionCell";
        mimeCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        
//        if (cell.contentView) {
//            NSArray *array = cell.contentView.subviews;
//            for (UIView *view in array) {
//                [view removeFromSuperview];
//            }
//        }
//        
        [cell setupCell];
        cell.dataCollectionView.delegate = self;
        cell.dataCollectionView.dataSource = self;
        [cell.dataCollectionView registerClass:[mimeItemCell class] forCellWithReuseIdentifier:@"mimeItemCell"];
        return cell;
    }
    return nil;
}


#pragma mark - cell的collectionView代理事件
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"mimeItemCell";
    mimeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell setupCellWithIndex:indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    flag = 1;
    [UIView hideTabbarWithAnimation:self.tabBarController];
    if (APPDELEGATE.isLogin == 1) {
        if (indexPath.row == 0) {
            myOrderController *myOrderVC = [[UIStoryboard storyboardWithName:@"myOrderStoryboard" bundle:nil]instantiateInitialViewController];
            [self.navigationController pushViewController:myOrderVC animated:YES];
        }else if (indexPath.row == 1) {
            PersonalViewController *personalVC = [PersonalViewController new];
            [self.navigationController pushViewController:personalVC animated:YES];
        }else if (indexPath.row == 2){
            MyCommentController *myAddressVC = [MyCommentController new];
            [self.navigationController pushViewController:myAddressVC animated:YES];
        }else if (indexPath.row == 3){
            MyAddressController *myAddressVC = [MyAddressController new];
            [self.navigationController pushViewController:myAddressVC animated:YES];
        }
    }else{
        [self toLoginView];
    }
    
}

#pragma mark - 跳转登录注册页面
-(void)toLoginView{
    flag = 1;
    [UIView hideTabbarWithAnimation:self.tabBarController];
    
    LoginAndRegisterViewController *loginAndRegisterVC = [[UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil] instantiateInitialViewController];
    [self.navigationController pushViewController:loginAndRegisterVC animated:YES];
//    [self presentViewController:loginAndRegisterVC animated:YES completion:nil];
}

#pragma mark - 接收登录成功通知的事件
-(void)loginSuccess:(NSNotification *)notice{
    isLoginView = 1;
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:loginSuccessNotification object:nil];
}

@end
