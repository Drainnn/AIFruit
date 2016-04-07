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
#import "drawTestView.h"

@interface FruitListTableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    BOOL clicked;
}

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) drawTestView *categoryView;

@end

@implementation FruitListTableViewController


-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(drawTestView *)categoryView{
    if (_categoryView == nil) {
        _categoryView = [[drawTestView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    }
    return _categoryView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    clicked = false;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;
    
    
    self.navigationItem.title = self.tableViewTitle;
   
    
    self.tableView.tableFooterView = [[UIView alloc]init];
   
    [self sendRequest];
    [self setupTitleView];
    
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
//    tapRecognizer.numberOfTapsRequired = 1;
//    [self.navigationItem.titleView addGestureRecognizer:tapRecognizer];
    
    
}

//-(void)tapClicked:(UITapGestureRecognizer *)recognizer{
//    NSLog(@"点击");
//}

-(void)setupTitleView{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn setTitle:self.categoryName forState:UIControlStateNormal];
    [btn setTitleColor:themeColor forState:UIControlStateNormal];
    UIFont *font = UIFontWithSize(16);
    btn.titleLabel.font = font;
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
}

-(void)clicked:(id)sender{
    if (!clicked) {
        [self setCollectionView];
        clicked = true;
    }else{
        [self removeListView];
        clicked = false;
    }

}

-(void)setCollectionView{
//    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
//    UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200 ) collectionViewLayout:fl];
//    view.delegate = self;
//    view.dataSource = self;
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    
    
    [_categoryView setBackgroundColor:[UIColor redColor]];
    [_categoryView setupView];
    [UIView animateWithDuration:0.2 animations:^{
        _categoryView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200) ;
    }];
    [self.view addSubview:_categoryView];
    self.view.alpha = 0.9f;
}

-(void)removeListView{
    
    [UIView animateWithDuration:0.2 animations:^{
        _categoryView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 0);
    } completion:^(BOOL finished) {
        NSArray *subViewArr = _categoryView.subviews;
        for (UIView *view in subViewArr) {
            [view removeFromSuperview];
        }
        [_categoryView removeFromSuperview];
        self.view.alpha = 1.0f;
    }];
    
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [[UICollectionViewCell alloc]init];
    return cell;
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
