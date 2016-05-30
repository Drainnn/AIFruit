//
//  orderDetailController.m
//  AIFruit
//
//  Created by Kosne on 16/5/11.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "orderDetailController.h"
#import "orderBasicInfoCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "OrderDetail.h"
#import "OrderFruitInfo.h"
#import "orderAddressCell.h"

@interface orderDetailController ()<UITableViewDataSource, UITableViewDelegate>{
    int flag;
}

@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) OrderDetail *orderDetail;

@end

@implementation orderDetailController

-(UITableView *)dataTableView{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _dataTableView.tableFooterView = [UIView new];
//        _dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.sectionHeaderHeight = 1.0;
        _dataTableView.sectionFooterHeight = 0.001f;
        
    }
    return _dataTableView;
}

-(OrderDetail *)orderDetail{
    if (!_orderDetail) {
        _orderDetail = [[OrderDetail alloc]init];
    }
    return _orderDetail;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    flag = 1;
    [self.view addSubview:self.dataTableView];
    [self sendRequest];
}

#pragma mark - 发送接口请求
-(void)sendRequest{
    NSDictionary *para = @{
                           @"orderNO":self.orderNO
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:orderDetailUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            
            flag = 1;
            NSDictionary *dic = dict[@"data"];
            OrderDetail *detail = [OrderDetail objectWithKeyValues:dic];
            self.orderDetail = detail;
            
            [self.dataTableView reloadData];
            
        }else{
            NSLog(@"请求结果错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送请求失败");
        flag++;
        if (flag < 4) {
            [self sendRequest];
        }
    }];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"订单详情";
    }else{
        return @"配送地址";
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 130;
    }else{
        return 60;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifier = @"orderBasicInfoCell";
        orderBasicInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil ]firstObject];
        }
        
        [cell setupCellWithOrderDetail:self.orderDetail];
        
        return cell;
    }else{
        static NSString *identifier = @"orderAddressCell";
        orderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        
        [cell setupCellWithOrderDetail:self.orderDetail];
        return cell;
    }
    
}



@end
