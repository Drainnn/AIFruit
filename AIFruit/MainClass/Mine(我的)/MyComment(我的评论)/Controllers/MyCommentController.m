//
//  MyCommentController.m
//  AIFruit
//
//  Created by Kosne on 16/5/16.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "MyCommentController.h"
#import "AFNetworking.h"
#import "Comment.h"
#import "MJExtension.h"
#import "AppDelegate.h"
#import "commentCell.h"

@interface MyCommentController ()<UITableViewDataSource,UITableViewDelegate>{
    int flag;
}

@property (nonatomic, strong) UITableView *dataTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MyCommentController

-(UITableView *)dataTableView{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.tableFooterView = [UIView new];
        _dataTableView.rowHeight = 82;
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
    self.title = @"我的评论";
    
    [self.view addSubview:self.dataTableView];
    
    [self sendRequest];
}

-(void)sendRequest{
    NSDictionary *para = @{
                           @"userId":@(APPDELEGATE.userinfo.id)
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:MyCommentByUserId parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            
            NSArray *array = dict[@"data"];
            for (NSDictionary *dic in array) {
                Comment *comment = [Comment objectWithKeyValues:dic];
                [self.dataArray addObject:comment];
            }
            
            [self.dataTableView reloadData];
        }else{
            NSLog(@"请求结果失败");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送请求失败");
        if (flag < 4) {
            flag++;
            [self sendRequest];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"commentCell";
    commentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"commentCell" owner:nil options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Comment *comment = [self.dataArray objectAtIndex:indexPath.row];
    [cell setupCellWithComment:comment];
    return cell;
}


@end
