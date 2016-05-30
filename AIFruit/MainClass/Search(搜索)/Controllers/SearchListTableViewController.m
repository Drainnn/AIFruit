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
#import "MBProgressHUD.h"

@interface SearchListTableViewController (){
    int flag;
}

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UIView *noresultView;

@property (nonatomic, strong) MBProgressHUD *waitHud;

@end

@implementation SearchListTableViewController

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UIView *)noresultView{
    if (!_noresultView) {
        _noresultView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        _noresultView.center = self.tableView.center;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 50)];
        label.text = [NSString stringWithFormat:@"没有搜索到“%@”",self.keyword];
        [_noresultView addSubview:label];
    }
    return _noresultView;
}

-(MBProgressHUD *)waitHud{
    if (!_waitHud) {
        _waitHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    }
    return _waitHud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = 1;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = BGC_SEARCHTABLEVIEW;
    
    self.title = @"搜索结果";
    [self sendRequest];
    [self showhud];
}

-(void)showhud{
    self.waitHud.mode = MBProgressHUDModeIndeterminate;
    self.waitHud.color = [UIColor grayColor];
    self.waitHud.margin = 10.f;
    self.waitHud.removeFromSuperViewOnHide = YES;
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
        [self.waitHud hide:YES];
        
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
                [self.tableView addSubview:self.noresultView];
            }
        }
        else{
            NSLog(@"接口请求返回错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求接口失败");
        if (flag < 5) {
            flag++;
            [self sendRequest];
        }
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
