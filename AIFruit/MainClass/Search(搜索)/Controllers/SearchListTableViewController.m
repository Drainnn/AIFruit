//
//  SearchListTableViewController.m
//  AIFruit
//
//  Created by Kosne on 16/3/16.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "SearchListTableViewController.h"
#import "FruitInfoTableViewCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "FruitList.h"
#import "FruitInfoTableViewCell.h"
#import "detailViewController.h"

@interface SearchListTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation SearchListTableViewController

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
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = BGC_SEARCHTABLEVIEW;
    
    [self sendRequest];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendRequest{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *para = @{
                           @"keyword" : self.keyword
                           };
    [manager GET:SearchFruitByKeywordURL parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *result = [dict valueForKey:@"code"];
        if ([result isEqualToString:@"200"]) {
            NSArray *arr = [dict valueForKey:@"data"];
            
            if (arr.count > 0) {
                
                for (NSDictionary *dic in arr) {
                    FruitList *list = [FruitList objectWithKeyValues:dic    ];
                    [self.dataArr addObject:list];
                }
                
                [self.tableView reloadData];
                
            }
            else{
                NSLog(@"null");
            }
        }
        else{
            NSLog(@"接口请求返回错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求接口失败");
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
    else{
        return nil;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    detailViewController *detailVC = [detailViewController new];
    FruitList *list = [self.dataArr objectAtIndex:indexPath.row];
    detailVC.id = list.id;
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
