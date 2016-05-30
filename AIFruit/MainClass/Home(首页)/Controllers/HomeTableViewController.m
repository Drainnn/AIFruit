
//
//  HomeTableViewController.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "HomeTableViewController.h"

#import "bannerViewCell.h"
#import "chaozhiqiangxianCell.h"
#import "shouyejingxuanCell.h"
#import "detailViewController.h"
#import "AFNetworking.h"
#import "MainImg.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"


@interface HomeTableViewController (){
    int flag;
}

@property (nonatomic, copy) NSArray *imgArr;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MBProgressHUD *waitHud;

@end

@implementation HomeTableViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(MBProgressHUD *)waitHud{
    if (!_waitHud) {
        _waitHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    }
    return _waitHud;
}


-(NSArray *)imgArr{
    if (!_imgArr) {
        _imgArr = @[@"banner11.png",@"banner22.png",@"banner33.png"];
    }
    return _imgArr;
}

-(void)showhud{
    self.waitHud.mode = MBProgressHUDModeIndeterminate;
    self.waitHud.color = [UIColor grayColor];
    self.waitHud.margin = 10.f;
    self.waitHud.removeFromSuperViewOnHide = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    flag = 1;
    [self showhud];
    UIFont *font = UIFontWithSize(16);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : themeColor,NSFontAttributeName : font}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.tabBarController.tabBar.translucent = NO;
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   self.tableView.backgroundColor = UIColorWithRGBA(246, 246, 246, 1);
 
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    [self sendRequest];
}

-(void)sendRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:GetShouyejingxuanUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            [self.waitHud hide:YES];
            NSArray *arr = dict[@"data"];
            for (NSDictionary *dic in arr) {
                MainImg *mainImg = [MainImg objectWithKeyValues:dic];
                [self.dataArray addObject:mainImg];
            }
            [self.tableView reloadData];
            flag = 1;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (flag < 6) {
            flag++;
            [self sendRequest];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else{
        return self.dataArray.count;
    }
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section == 1) {
//        return @"首页精选";
//    }
//    return nil;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 1) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
//        label.text = @"首页精选";
//        label.font = UIFontWithSize(14);
//        return label;
//    }
//    return nil;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }else{
        if (indexPath.row == 0) {
            return 35;
        }else{
           return 100;
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"bannerCell";
        bannerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"bannerViewCell" owner:nil options:nil] firstObject];
        }
        [cell setupCellWithImages:self.imgArr];
        return cell;
    }else{
        
        if (indexPath.row == 0) {
            static NSString *identifier = @"titleCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.textLabel.text = @"首页推荐";
            [cell setBackgroundView:[UIView new]];
            [cell setBackgroundColor:[UIColor clearColor]];
            return cell;
        }else{
            static NSString *cellIdentifier = @"shouyejingxuanCell";
            shouyejingxuanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil] firstObject];
            }
            [cell setBackgroundView:[UIView new]];
            [cell setBackgroundColor:[UIColor clearColor]];
            MainImg *mainImg = [self.dataArray objectAtIndex:indexPath.row - 1];
            [cell setupCellWithMainImg:mainImg];
            return cell;
        }
       
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row > 0) {
            detailViewController *detailVC = [detailViewController new];
            MainImg *mainImg = [self.dataArray objectAtIndex:indexPath.row - 1];
            detailVC.id = mainImg.fruitId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }
    
}


@end
