//
//  PersonalViewController.m
//  AIFruit
//
//  Created by Kosne on 16/4/26.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "PersonalViewController.h"
#import "personalInfoCell.h"
#import "personalInfoHeadImgCell.h"
#import "userInfo.h"
#import "MJExtension.h"
#import "personalLogoutCell.h"
#import "AppDelegate.h"
#import "UserInfo.h"

@interface PersonalViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *dataTableView;

@end

@implementation PersonalViewController


-(UITableView *)dataTableView{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.tableFooterView = [UIView new];
        _dataTableView.sectionHeaderHeight = 0.1;
//        _dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _dataTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.dataTableView];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;
    self.title = @"个人信息";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 7;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }
    }
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *identifier = @"personalInfoHeadImgCell";
            personalInfoHeadImgCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
            }
            [cell setupCell];
            return cell;
        }
        else{
            static NSString *identifier = @"personalInfoCell";
            personalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
            }
            [cell setupCellWithIndex:indexPath.row];
            return cell;
        }
        
    }else{
        static NSString *identifier = @"personalLogoutCell";
        personalLogoutCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        
        [cell setupCell];
        __weak PersonalViewController *weakSelf = self;
        cell.didlogoutBtn = ^(){
            [weakSelf didLogoutBtn];
        };
        return cell;
    }
}

-(void)didLogoutBtn{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:APPDELEGATE.userInfoFilePath]) {
        
        [manager removeItemAtPath:APPDELEGATE.searchRecordFilePath error:nil];
        
        APPDELEGATE.isLogin = 0;
        UserInfo *info = [[UserInfo alloc]init];
        APPDELEGATE.userinfo = info;
    }
    
    NSNotification *notification = [NSNotification notificationWithName:loginSuccessNotification object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
