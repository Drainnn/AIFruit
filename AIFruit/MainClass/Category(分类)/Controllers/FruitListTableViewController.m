//
//  FruitListTableViewController.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "FruitListTableViewController.h"
#import "AFNetworking.h"
#import "FruitInfoTableViewCell.h"
#import "FruitInfo.h"
#import "MJExtension.h"

@interface FruitListTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation FruitListTableViewController


-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    

    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;
   
    
    
    self.navigationItem.title = self.tableViewTitle;
   
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self sendRequest];
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 发送接口请求
-(void)sendRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *para = @{
                           @"categoryID":@(self.categoryId)
                           };
    
    [manager GET:FruitListByCategoryURL parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = [dict valueForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            
            NSArray *arr = [dict valueForKey:@"result"];
            
            for (NSDictionary *dic in arr) {
                FruitList *list = [FruitList objectWithKeyValues:dic];
                [self.dataArr addObject:list];
            }
        
            [self.tableView reloadData];
            
        }else{
            NSLog(@"发送接口请求返回错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 115;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArr.count > 0) {
        
        static NSString *identifier = @"fruitInfo";
        FruitInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FruitInfoTableViewCell" owner:nil options:nil] firstObject];
        }
        
        
        FruitList *list = [self.dataArr objectAtIndex:indexPath.row];
        [cell setupCellWithFruitList:list];
        
        return cell;
    }
    
    return nil;
    
}


@end
