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
#import "FruitListViewController.h"
#import "MBProgressHUD.h"

@interface CategoryTableViewController ()
{
    int tempTag;
}

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *cateNameArr;

@property (nonatomic, strong) MBProgressHUD *waitHud;

@end

@implementation CategoryTableViewController


#pragma mark - 懒加载
- (NSMutableArray *)dataArr{
    
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}

- (NSMutableArray *)cateNameArr{
    
    if (_cateNameArr == nil) {
        _cateNameArr = [NSMutableArray array];
    }
    
    return _cateNameArr;
}

-(MBProgressHUD *)waitHud{
    if (!_waitHud) {
        _waitHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    }
    return _waitHud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFont *font = UIFontWithSize(16);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : themeColor,NSFontAttributeName : font}];
    
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = UIColorWithRGBA(233, 234, 237, 1);
    
     [self sendRequest];
  
    [self showhud];
}

-(void)showhud{
    self.waitHud.mode = MBProgressHUDModeIndeterminate;
    self.waitHud.color = [UIColor grayColor];
    self.waitHud.margin = 10.f;
    self.waitHud.removeFromSuperViewOnHide = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    tempTag = 1;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
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
            
            [self.waitHud hide:YES];
            
            NSArray *arr = [NSArray arrayWithArray:[dict valueForKey:@"data"]];
            
            for (NSDictionary *dic in arr) {
                CategoryList *list = [CategoryList setupCategoryList:dic];
                [self.dataArr addObject:list];
                [self.cateNameArr addObject:list.cateName];
            }
            
            [self.tableView reloadData];
            
        }else{
            NSLog(@"接口请求返回错误");
        }
        
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        

        if (tempTag < 4) {
            [self sendRequest];  //这里不能这样写 只是临时需要 需要改进！！！！
        }
        tempTag ++;
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
    VC.cateNameArr = self.cateNameArr;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)setWarnInfor:(NSString *)info{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.color = [UIColor grayColor];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

@end
