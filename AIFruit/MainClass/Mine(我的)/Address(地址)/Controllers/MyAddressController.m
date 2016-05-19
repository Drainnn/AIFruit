//
//  MyAddressController.m
//  AIFruit
//
//  Created by Kosne on 16/4/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "MyAddressController.h"
#import "AFNetworking.h"
#import "Address.h"
#import "MJExtension.h"
#import "AppDelegate.h"
#import "MyAddressInfoCell.h"
#import "EditAddressController.h"
#import "newAddressController.h"

@interface MyAddressController ()<UITableViewDataSource,UITableViewDelegate>{
    int flag;
}

@property (nonatomic, strong) UITableView *dataTableView;

@property (nonatomic, strong) NSMutableArray *addressArr;

@end

@implementation MyAddressController

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
        _dataTableView.rowHeight = 80;
    }
    return _dataTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = 1;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;
    self.title = @"我的收货地址";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn addTarget:self action:@selector(addNewAddress:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = addItem;
    
    
    [self.view addSubview:self.dataTableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self sendRequest];
}

#pragma mark - 添加地址
-(void)addNewAddress:(UIButton *)sender{
    
    newAddressController *newAddVC = [[UIStoryboard storyboardWithName:@"newAddressStoryboard" bundle:nil]instantiateInitialViewController];
    [self.navigationController pushViewController:newAddVC animated:YES];
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
    static NSString *identifier = @"MyAddressInfoCell";
    MyAddressInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
    }
    Address *address = [self.addressArr objectAtIndex:indexPath.row];
    [cell setupCellWithAdd:address];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Address *address = [self.addressArr objectAtIndex:indexPath.row];
    EditAddressController *editaddressVC = [EditAddressController new];
    editaddressVC.address = address;
    [self.navigationController pushViewController:editaddressVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
