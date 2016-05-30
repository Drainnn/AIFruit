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
#import "IFAddCommentViewController.h"
#import "AFAddCommentController.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AliOrder.h"
#import "MBProgressHUD.h"

@interface myOrderController ()<categorySegmentDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    int flag1;
    int flag2;
    int flag3;
    int flag;
}

@property (nonatomic, strong) UITableView *dataTableView;

@property (nonatomic,strong) categorySegment *segmentControl;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIScrollView *contScrollView;

@property (nonatomic, strong) waitCommentController *waitCommentView;
@property (nonatomic, strong) waitPayTableController *waitPayView;
@property (nonatomic, strong) finishOrderTableController *finishView;

@property (nonatomic, strong) NSMutableArray *waitCommentDataArray;
@property (nonatomic, strong) NSMutableArray *waitCommentOrderNOArray;

@end

@implementation myOrderController

-(NSMutableArray *)waitCommentDataArray{
    if (!_waitCommentDataArray) {
        _waitCommentDataArray = [NSMutableArray array];
    }
    return _waitCommentDataArray;
}

-(NSMutableArray *)waitCommentOrderNOArray{
    if (!_waitCommentOrderNOArray) {
        _waitCommentOrderNOArray = [NSMutableArray array];
    }
    return _waitCommentOrderNOArray;
}

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
        self.waitPayView.didToPayOrder = ^(Order *order){
            NSString *orderNO = order.orderNO;
            [weakSelf toAlipay:orderNO];
        };
        
        [_contScrollView addSubview:self.waitCommentView.dataTableView];
        self.waitCommentView.didtoaddcomment = ^(NSMutableArray *dataArray,NSInteger index){
            [weakSelf toCommentView:dataArray andIndex:index];
        };
        
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
    flag = 1;
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
//            if (self.waitCommentDataArray.count > 0) {
//                [self.waitCommentDataArray removeAllObjects];
//            }
//            if (self.waitCommentOrderNOArray.count > 0) {
//                [self.waitCommentOrderNOArray removeAllObjects];
//            }
            
            NSArray *arr = dict[@"data"];
            for (NSDictionary *dic in arr) {
                Order *order = [Order objectWithKeyValues:dic];
                [self.waitCommentView.dataArray addObject:order];
                [self.waitCommentDataArray addObject:order.imgUrls];
                [self.waitCommentOrderNOArray addObject:order.orderNO];
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
        if (flag3 < 6) {
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


#pragma mark - 跳转到添加评论页面
-(void)toCommentView:(NSMutableArray *)dataArray andIndex:(NSInteger)index{

    AFAddCommentController *addcommVC = [AFAddCommentController new];
    NSArray *array = [NSArray arrayWithArray:[self.waitCommentDataArray objectAtIndex:index]];
    NSString *orderNO = [self.waitCommentOrderNOArray objectAtIndex:index];
    addcommVC.dataArray = [NSArray arrayWithArray:array];
    addcommVC.orderNO = orderNO;
    [self.navigationController pushViewController:addcommVC animated:YES];
}

-(void)toAlipay:(NSString *)OrderNO{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    //        Product *product = [[Product alloc]init];
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088802366482234";
    NSString *seller = @"804063213@qq.com";
    NSString *privateKey =@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANE71e0Yl8VGfJX4glWRhMay6vdfU/fQ4+1Bn4tEdSn98hG4tIrW1FEIQJjyZpZSSxX4nyG/aZbxwDH8FfEYvsPWd2nMJ0HfI3xBujeJsdCj/Dvje2KTjg07Jl7W+ENFz3QEWvGQU557z/kJU1CAse6eD0y5UImEErgVVSJ9h87pAgMBAAECgYBRvyP8p0AcxkZEvbwGPH14uEyO64K97rIubxYrbkqsZlgeTmDTYc2//w5l80bbcjl90w4xPDy/yaICpW/ZK4bT/QdXIuH33pxOx1CteXfc0j26fLfFUWVxLuPPSa9U1bbqCsIaYLEQ9Ti2/4KphU0fw5SDbHgY7ujF8eij/BxxJQJBAP+sGQfU0jZv0DQqReJIGcfcbMJNiTpgQ2ODIA599BLEoNcOkbMGYmXlQEGZuF3vJjq1JZfWIYw3tY9nefrTI5cCQQDRgH+bAlB1lH6JH6NT6ndceUOsIR8DWRgdHTrJ+KZFnHV6gHaDGEneux5wJT4xl246iZBFOdg/BkhppeSw+PF/AkEA2Sbjr5ob3S6EyPmql3Gjq/PU0Aco6dL/CZNCc+yYlCQ7c80lBMgEZQUc2Vrlk6rebniS8G5n2f8rDxzVJquUCwJAeqq3jKZ1P/Nbh6SLuGXPz8h9FDsscoRnNxzXQE0j5hxvOPQg8C93iT+c2eMkoFrfQs0rOS1ebcCbA6kL14dbtwJAeu2niLVy9kJQjbbBOvgxke1V+0cxPmRnvKDoYvb4briZb0RyGnnvMLFYgv3OOJLqtbnWvnyaOsRZ7MRX7TIO/w==";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    AliOrder *order = [[AliOrder alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = @"234234324234"; //订单ID（由商家自行制定）
    order.subject = @"2"; //商品标题
    order.body = @"测试数据"; //商品描述
    order.totalFee = [NSString stringWithFormat:@"%.2f",0.1]; //商品价格
    NSLog(@"price:%@",order.totalFee);
    order.notifyURL =  @"http://www.baidu.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"aifruit";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    //        if (signedString != nil) {
    orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                   orderSpec, signedString, @"RSA"];
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
    }];
    [self sendPaySuccessRequest:OrderNO];
    
}

-(void)sendPaySuccessRequest:(NSString *)orderNO{
    NSDictionary *para = @{
                           @"orderNO":orderNO
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:paySuccessOrderUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            
            
            [self popView];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (flag < 5) {
            flag ++;
        }
    }];
}

-(void)popView{

    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
