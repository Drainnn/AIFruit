//
//  CategoryTableViewController.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "CategoryInfoTableViewCell.h"
#import "AFNetworking.h"
#import "CategoryList.h"
#import "MJExtension.h"
#import "FruitListTableViewController.h"
#import "FruitListViewController.h"

@interface CategoryTableViewController ()


@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation CategoryTableViewController


#pragma mark - 懒加载
- (NSMutableArray *)dataArr{
    
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFont *font = UIFontWithSize(16);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : themeColor,NSFontAttributeName : font}];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = UIColorWithRGBA(233, 234, 237, 1);
    
     [self sendRequest];
  
    
}

- (void)viewWillAppear:(BOOL)animated{
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)sendRequest{
    NSString *urlPath = CategoryInfoURL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = [dict valueForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            NSArray *arr = [NSArray arrayWithArray:[dict valueForKey:@"result"]];
            
            for (NSDictionary *dic in arr) {
                CategoryList *list = [CategoryList setupCategoryList:dic];
                [self.dataArr addObject:list];
            }
            
            
            [self.tableView reloadData];
            
        }else{
            NSLog(@"接口请求返回错误");
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (_dataArr.count > 0) {
        static NSString *identifier = @"categoryInfo";
        CategoryInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CategoryInfoTableViewCell" owner:nil options:nil] firstObject];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CategoryList *list = [self.dataArr objectAtIndex:indexPath.row];
        [cell setupCellWithCategoryList:list];
        
        return cell;
    }
    
    return nil;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FruitListViewController *VC = [[UIStoryboard storyboardWithName:@"FruitList" bundle:nil]instantiateInitialViewController];
    CategoryList *list = [self.dataArr objectAtIndex:indexPath.row];
    VC.categoryId = list.id;
    VC.categoryName = list.cateName;
    [self.navigationController pushViewController:VC animated:YES];
}


@end
