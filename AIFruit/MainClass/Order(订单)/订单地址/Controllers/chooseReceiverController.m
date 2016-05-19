//
//  chooseReceiverController.m
//  AIFruit
//
//  Created by Kosne on 16/5/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "chooseReceiverController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "Address.h"
#import "MJExtension.h"
#import "chooseReceiverCell.h"
#import "chooseAddressEditController.h"

@interface chooseReceiverController ()<UITableViewDataSource,UITableViewDelegate>{
    int flag;
}

@property (nonatomic, strong) UITableView *dataTableView;

@property (nonatomic, strong) NSMutableArray *addressArr;

@end

@implementation chooseReceiverController

-(NSMutableArray *)addressArr{
    if (!_addressArr) {
        _addressArr = [NSMutableArray array];
    }
    return _addressArr;
}

-(UITableView *)dataTableView{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.tableFooterView = [UIView new];
        _dataTableView.rowHeight = 60;
    }
    return _dataTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = 1;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;
    self.title = @"选择收货人";
    
    [self.view addSubview:self.dataTableView];
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self sendRequest];
}


-(void)sendRequest{
    NSDictionary *para = @{
                           @"userId":@(APPDELEGATE.userinfo.id)
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:myAddressUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            
            if (self.addressArr.count > 0) {
                [self.addressArr removeAllObjects];
            }
            
            NSArray *arr = dict[@"data"];
            for (NSDictionary *dic in arr) {
                Address *address = [Address objectWithKeyValues:dic];
                [self.addressArr addObject:address];
            }
            
            [self.dataTableView reloadData];
        }else{
            NSLog(@"请求数据出错");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
        if (flag < 4) {
            [self sendRequest];
        }
        flag++;
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"chooseReceiverCell";
    chooseReceiverCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
    }
    Address *address = [self.addressArr objectAtIndex:indexPath.row];
    
    [cell setupCellWithAddress:address];
    
    __weak chooseReceiverController *weakSelf = self;
    cell.didBtnClicked = ^(Address *address){
        [weakSelf pushToEditAddressView:address];
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Address *address = [self.addressArr objectAtIndex:indexPath.row];
    _didReturnAddress(address);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pushToEditAddressView:(Address *)address{
    chooseAddressEditController *VC = [chooseAddressEditController new];
    VC.address = address;
    [self.navigationController pushViewController:VC animated:YES];
}

@end
