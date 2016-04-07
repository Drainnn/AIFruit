//
//  FruitListViewController.m
//  AIFruit
//
//  Created by Kosne on 16/4/7.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "FruitListViewController.h"
#import "categorySegment.h"
#import "FruitInfoTableViewCell.h"
#import "drawTestView.h"
#import "AFNetworking.h"
#import "FruitList.h"
#import "MJExtension.h"

@interface FruitListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL clicked;
}


@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) drawTestView *categoryView;

@property (nonatomic,strong) categorySegment *segmentControl;

@end

@implementation FruitListViewController

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
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;
    
    
    [self initdataTableView];
    [self initcategorySegment];
    [self setupTitleView];
     self.automaticallyAdjustsScrollViewInsets = NO;
    [self sendRequest];
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
            
            [self.dataTableView reloadData];
            
        }else{
            NSLog(@"发送接口请求返回错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
}


#pragma mark - 导航栏标题视图
-(void)setupTitleView{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn setTitle:self.categoryName forState:UIControlStateNormal];
    [btn setTitleColor:themeColor forState:UIControlStateNormal];
    UIFont *font = UIFontWithSize(16);
    btn.titleLabel.font = font;
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
}
#pragma mark - 标题点击事件
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


#pragma mark - 设定选项控制
-(void)initcategorySegment{
    self.segmentControl = [[categorySegment alloc]initWithFrame:CGRectMake(-0.5, navigation_height, self_screen_width+1, categorySegmentHeight)];
    NSArray *titleArr = @[@"默认",@"价格",@"热销"];
    [self.segmentControl addTitleBtnWithTitleArray:titleArr];
    [self.view addSubview:self.segmentControl];
}

#pragma mark - 添加tableView
-(void)initdataTableView{
    self.dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, navigation_height+categorySegmentHeight, self_screen_width , self_screen_height-self_tabbar_height-navigation_height-categorySegmentHeight)];
    self.dataTableView.tableFooterView = [[UIView alloc]init];
    self.dataTableView.dataSource = self;
    self.dataTableView.delegate = self;
    self.dataTableView.rowHeight = 115;
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.dataTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArr.count > 0) {
         
         static NSString *identifier = @"fruitInfo";
         FruitInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
         if (!cell) {
             cell = [[[NSBundle mainBundle] loadNibNamed:@"FruitInfoTableViewCell" owner:nil options:nil] firstObject];
         }
         
         FruitList *list = [self.dataArr objectAtIndex:indexPath.row];
         [cell setupCellWithFruitList:list];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
     
     }
    return nil;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
