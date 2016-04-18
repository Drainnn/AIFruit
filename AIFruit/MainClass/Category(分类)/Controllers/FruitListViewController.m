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
#import "categoryNameCell.h"
#import "AFNetworking.h"
#import "FruitList.h"
#import "MJExtension.h"
#import "detailViewController.h"
#import "OtherViewController.h"

#define btn_height 45

@interface FruitListViewController ()<UITableViewDataSource,UITableViewDelegate,categorySegmentDelegate>{
    BOOL clicked;
    NSInteger currentIndex;
}


@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) drawTestView *categoryView;

@property (nonatomic,strong) categorySegment *segmentControl;

@property (nonatomic, strong) UIView *bgView;

@end

@implementation FruitListViewController

#pragma mark - 懒加载
-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(drawTestView *)categoryView{
    if (!_categoryView) {
        _categoryView = [[drawTestView alloc]initWithFrame:CGRectMake(0, navigation_height, self.view.bounds.size.width, 0) andCount:self.cateNameArr.count];
        [_categoryView setupViewWithArray:self.cateNameArr];
        [self.categoryView setBackgroundColor:[UIColor whiteColor]];
    }
    return _categoryView;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:self.view.frame];
        [_bgView setBackgroundColor:[UIColor grayColor]];
        [_bgView setAlpha:0.3];
    }
    return _bgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;

    clicked = false;

    [self initdataTableView];
    [self initcategorySegment];
    [self setupTitleView];
     self.automaticallyAdjustsScrollViewInsets = NO;
    currentIndex = 7;
    [self sendRequestWithIndex:0];
}

#pragma mark - 发送接口请求
-(void)sendRequestWithIndex:(NSInteger)index{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *para = @{
                           @"categoryID":@(self.categoryId)
                           };
    NSString *url = nil;
    if (index == 0) {
        url = FruitListByCategoryURL;
    }else if (index == 1){
        url = FrultListByCategorySortByPrice;
    }else if (index == 2){
        url = FrultListByCategorySortBySales;
    }
    
    if (currentIndex != index) {
        [manager GET:url parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            NSString *code = [dict valueForKey:@"code"];
            if ([code isEqualToString:@"200"]) {
                
                NSArray *arr = [dict valueForKey:@"data"];
                
                if (self.dataArr.count) {
                    [self.dataArr removeAllObjects];
                }
                
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
        currentIndex = index;
    }
}

#pragma mark - 初始化菜单视图
-(void)initCategoryMenu{
    drawTestView *view = [[drawTestView alloc]initWithFrame:CGRectMake(0, navigation_height, self_screen_width, 0)];
    _categoryView = view;
    [self.view addSubview:_categoryView];
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
        [self addCollectionView];
        clicked = true;
    }else{
        [self removeListView];
        clicked = false;
    }
    
}

-(void)addCollectionView{
    [self.view addSubview:self.categoryView];
    [UIView animateWithDuration:0.2 animations:^{
        self.categoryView.frame = CGRectMake(0, navigation_height, self.view.bounds.size.width, (self.cateNameArr.count/2+1)*btn_height+0.5) ;
    }];
    [self.view bringSubviewToFront:self.categoryView];
    [self.dataTableView addSubview:self.bgView];
    self.dataTableView.alpha = 0.7;
    
}

-(void)removeListView{
    [UIView animateWithDuration:0.2 animations:^{
        self.categoryView.frame = CGRectMake(0, navigation_height, self.view.bounds.size.width, 0);
    } completion:^(BOOL finished) {
        [self.categoryView removeFromSuperview];
    }];
    [self.bgView removeFromSuperview];
    self.dataTableView.alpha = 1.0;
}


#pragma mark - 设定选项控制
-(void)initcategorySegment{
    self.segmentControl = [[categorySegment alloc]initWithFrame:CGRectMake(-0.5, navigation_height, self_screen_width+1, categorySegmentHeight)];
    NSArray *titleArr = @[@"默认",@"价格",@"热销"];
    [self.segmentControl addTitleBtnWithTitleArray:titleArr];
    self.segmentControl.delegate = self;
    [self.view addSubview:self.segmentControl];
}

//选项卡
-(void)didselectedTitle:(NSInteger)selectedIndex{
    [self sendRequestWithIndex:selectedIndex];
}



#pragma mark - 添加tableView
-(void)initdataTableView{
    self.dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, navigation_height+categorySegmentHeight, self_screen_width , self_screen_height-self_tabbar_height-navigation_height-categorySegmentHeight)];
    self.dataTableView.tableFooterView = [[UIView alloc]init];
    self.dataTableView.dataSource = self;
    self.dataTableView.delegate = self;
    self.dataTableView.rowHeight = 115;
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataTableView.backgroundColor = UIColorWithRGBA(245, 245, 245, 1.0f);
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    detailViewController *detailVC = [detailViewController new];
//    OtherViewController *otherVC = [OtherViewController new];
    FruitList *list = [self.dataArr objectAtIndex:indexPath.row];
    detailVC.id = list.id;
    [self.navigationController pushViewController:detailVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
