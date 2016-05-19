//
//  myOrderController.m
//  AIFruit
//
//  Created by Kosne on 16/4/29.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "myOrderController.h"
#import "categorySegment.h"
#import "AFNetworking.h"
#import "Order.h"
#import "MJExtension.h"
#import "myOrderInfoCell.h"
#import "AppDelegate.h"
#import "orderDetailController.h"
#import "waitPayTableController.h"
#import "waitCommentController.h"
#import "finishOrderTableController.h"

@interface myOrderController ()<categorySegmentDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    int flag1;
    int flag2;
    int flag3;
}

@property (nonatomic, strong) UITableView *dataTableView;

@property (nonatomic,strong) categorySegment *segmentControl;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIScrollView *contScrollView;

@property (nonatomic, strong) waitCommentController *waitCommentView;
@property (nonatomic, strong) waitPayTableController *waitPayView;
@property (nonatomic, strong) finishOrderTableController *finishView;

@end

@implementation myOrderController


-(waitPayTableController *)waitPayView{
    if (!_waitPayView) {
        _waitPayView = [waitPayTableController new];
        
    }
    return _waitPayView;
}
-(waitCommentController *)waitCommentView{
    if (!_waitCommentView) {
        _waitCommentView = [waitCommentController new];
        
    }
    return _waitCommentView;
}
-(finishOrderTableController *)finishView{
    if (!_finishView) {
      
        _finishView = [finishOrderTableController new];
        
    }
    return _finishView;
}

-(UIScrollView *)contScrollView{
    if (!_contScrollView) {
        _contScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, categorySegmentHeight, self_screen_width, self_screen_height)];
        _contScrollView.contentSize = CGSizeMake(self_screen_width * 3, 0);
        [_contScrollView sizeToFit];

        _contScrollView.pagingEnabled = YES;
        _contScrollView.showsHorizontalScrollIndicator = NO;
        _contScrollView.delegate = self;
        
        __weak myOrderController *weakSelf = self;
        [_contScrollView addSubview:self.waitPayView.dataTableView];
        self.waitPayView.didToOrderDetail = ^(Order *order){
            [weakSelf pushOrderDetailView:order];
        };
        
        [_contScrollView addSubview:self.waitCommentView.dataTableView];
        
        [_contScrollView addSubview:self.finishView.dataTableView];
    }
    return _contScrollView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(categorySegment *)segmentControl{
    if (!_segmentControl) {
        _segmentControl = [[categorySegment alloc]initWithFrame:CGRectMake(-0.5, navigation_height, self_screen_width+1, categorySegmentHeight)];
        NSArray *titleArr = @[@"待支付",@"待评价",@"已完成"];
        [_segmentControl addTitleBtnWithTitleArray:titleArr];
        _segmentControl.delegate = self;
        [_segmentControl setBackgroundColor:[UIColor whiteColor]];
    }
    return _segmentControl;
}

//选项卡
-(void)didselectedTitle:(NSInteger)selectedIndex{
    switch (selectedIndex) {
        case 0:
            [_contScrollView setContentOffset:CGPointMake(0, -64) animated:YES];
            break;
        case 1:
            [_contScrollView setContentOffset:CGPointMake(self_screen_width, -64) animated:YES];
            break;
        case 2:
            [_contScrollView setContentOffset:CGPointMake(self_screen_width * 2, -64) animated:YES];
            break;
        default:
            break;
    }
    self.orderStatus = (int)selectedIndex + 1;
}

#pragma mark - 移动scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.segmentControl changeSelectItemWithcontentOffset:scrollView.contentOffset];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag1 = 1;
    flag2 = 1;
    flag3 = 1;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;
    self.title = @"我的订单";
    
//    [self.view addSubview:self.dataTableView];

    [self.view addSubview:self.contScrollView];
    [self.view addSubview:self.segmentControl];
    
    self.orderStatus = 1;
    [self sendwaitPayOrderRequest];
    [self sendwaitCommentOrderRequest];
    [self sendfinishOrderRequest];
}

#pragma mark - 查询待支付
-(void)sendwaitPayOrderRequest{
    NSDictionary *para = @{
                           @"userId":@(APPDELEGATE.userinfo.id)
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:waitPayOrderUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            flag1 = 1;
            if (self.waitPayView.dataArray.count > 0) {
                [self.waitPayView.dataArray removeAllObjects];
            }
            
            NSArray *arr = dict[@"data"];
            for (NSDictionary *dic in arr) {
                Order *order = [Order objectWithKeyValues:dic];
                [self.waitPayView.dataArray addObject:order];
            }
            [self.waitPayView.dataTableView reloadData];
        }else{
            NSLog(@"返回错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (flag1 < 4) {
            flag1++;
            [self sendwaitPayOrderRequest];
        }
        NSLog(@"发送请求失败");
    }];
}

#pragma mark - 查询待评论
-(void)sendwaitCommentOrderRequest{
    NSDictionary *para = @{
                           @"userId":@(APPDELEGATE.userinfo.id)
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:waitCommentOrderUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            flag2 = 1;
            if (self.waitCommentView.dataArray.count > 0) {
                [self.waitCommentView.dataArray removeAllObjects];
            }
            
            NSArray *arr = dict[@"data"];
            for (NSDictionary *dic in arr) {
                Order *order = [Order objectWithKeyValues:dic];
                [self.waitCommentView.dataArray addObject:order];
            }
            [self.waitCommentView.dataTableView reloadData];
        }else{
            NSLog(@"返回错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (flag2 < 4) {
            flag2++;
            [self sendwaitCommentOrderRequest];
        }
        NSLog(@"发送请求失败");
    }];
}

#pragma mark - 查询已完成订单
-(void)sendfinishOrderRequest{
    NSDictionary *para = @{
                           @"userId":@(APPDELEGATE.userinfo.id)
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:finishOrderUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            flag3 = 1;
            if (self.finishView.dataArray.count > 0) {
                [self.finishView.dataArray removeAllObjects];
            }
            
            NSArray *arr = dict[@"data"];
            for (NSDictionary *dic in arr) {
                Order *order = [Order objectWithKeyValues:dic];
                [self.finishView.dataArray addObject:order];
            }
            [self.finishView.dataTableView reloadData];
        }else{
            NSLog(@"返回错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (flag3 < 4) {
            flag3++;
            [self sendwaitCommentOrderRequest];
        }
        NSLog(@"发送请求失败");
    }];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"myOrderInfoCell";
    myOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil ]firstObject];
    }
    
    Order *order = [self.dataArray objectAtIndex:indexPath.section];
    [cell setupCellWithOrder:order];
    
    return cell;
    
}


#pragma mark - 点击cell跳转详情页面
-(void)pushOrderDetailView:(Order *)order{
    NSString *orderNO = order.orderNO;
    orderDetailController *orderDetailVC = [[UIStoryboard storyboardWithName:@"orderDetailStoryboard" bundle:nil]instantiateInitialViewController];
    orderDetailVC.orderNO = orderNO;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Order *order = [self.dataArray objectAtIndex:indexPath.section];
    NSString *orderNO = order.orderNO;
    orderDetailController *orderDetailVC = [[UIStoryboard storyboardWithName:@"orderDetailStoryboard" bundle:nil]instantiateInitialViewController];
    orderDetailVC.orderNO = orderNO;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
