//
//  waitCommentController.m
//  AIFruit
//
//  Created by Kosne on 16/5/13.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "waitCommentController.h"
#import "myOrderInfoCell.h"
#import "AFNetworking.h"
#import "Order.h"
#import "MJExtension.h"
#import "AppDelegate.h"


@interface waitCommentController ()<UITableViewDataSource,UITableViewDelegate>{
    int flag;
}


@end

@implementation waitCommentController

-(UITableView *)dataTableView{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(self_screen_width, 0, self_screen_width, self_screen_height - 80) style:UITableViewStyleGrouped];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    __weak waitCommentController *weakSelf = self;
    cell.tocommentclicked = ^(){
        [weakSelf toCommentView:indexPath.section];
    };
    
    return cell;
}

-(void)toCommentView:(NSInteger)index{
    _didtoaddcomment(self.dataArray,index);
    
}

@end
