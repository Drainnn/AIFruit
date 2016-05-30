//
//  waitPayTableController.m
//  AIFruit
//
//  Created by Kosne on 16/5/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "waitPayTableController.h"
#import "myOrderInfoCell.h"
#import "AFNetworking.h"
#import "Order.h"
#import "MJExtension.h"
#import "AppDelegate.h"

@interface waitPayTableController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    int flag;
}

@end

@implementation waitPayTableController

-(UITableView *)dataTableView{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self_screen_width, self_screen_height - 80) style:UITableViewStyleGrouped];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.rowHeight = 160;
        _dataTableView.sectionFooterHeight = 10;
        _dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _dataTableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    flag = 1;
    
    [self.view addSubview:self.dataTableView];
   
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"myOrderInfoCell";
    myOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil ]firstObject];
    }
    
    Order *order = [self.dataArray objectAtIndex:indexPath.section];
    [cell setupCellWithOrder:order];
    cell.ImgScrollView.delegate = self;
    __weak waitPayTableController *weakSelf = self;
    cell.topayclicked = ^(){
        NSInteger index = indexPath.section;
        [weakSelf topayView:index];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Order *order = [self.dataArray objectAtIndex:indexPath.section];
    _didToOrderDetail(order);
}

-(void)topayView:(NSInteger)index{
    Order *order = [self.dataArray objectAtIndex:index];
    _didToPayOrder(order);
}

@end
