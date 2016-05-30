//
//  orderViewController.m
//  AIFruit
//
//  Created by Kosne on 16/4/24.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "orderViewController.h"
#import "orderAddressCell.h"
#import "sendDataCell.h"
#import "payWayCell.h"
#import "billInfoCell.h"
#import "notesCell.h"
#import "orderFruitInfoCell.h"
#import "orderTotalCell.h"
#import "AppDelegate.h"
#import "orderBottomView.h"
#import "UIView+AnimationView.h"
#import "AFNetworking.h"
#import "Address.h"
#import "MJExtension.h"
#import "orderpayViewController.h"
#import "chooseReceiverController.h"

@interface orderViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    int flag;
}

@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) orderBottomView *bottomView;
@property (nonatomic, strong) Address *address;

@end

@implementation orderViewController

-(orderBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[orderBottomView alloc]initWithFrame:CGRectMake(0, self_screen_height-60, self_screen_width, 60)];
        __weak orderViewController *weakSelf = self;
        _bottomView.didsubmitBtn = ^(){
//            [weakSelf pushToOrderpayView];
            [weakSelf sendAddOrder];
        };
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = 1;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;

    [self initTableView];
    [self initBottomView];
    
    [self sendRequest];
}



-(void)sendRequest{
    NSDictionary *para = @{
                           @"userId":@(APPDELEGATE.userinfo.id)
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:defaultAddressUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            flag = 1;
            NSDictionary *dic = dict[@"data"];
            self.address = [Address objectWithKeyValues:dic];
            
            [self.dataTableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (flag < 4) {
            flag++;
            [self sendRequest];
        }
    }];
}

#pragma mark - 初始化tableView
-(void)initTableView{
    _dataTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _dataTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _dataTableView.delegate = self;
    _dataTableView.dataSource = self;
    _dataTableView.tableFooterView = [UIView new];
    _dataTableView.sectionFooterHeight = 10;
    _dataTableView.backgroundColor = UIColorWithRGB(235, 235, 235);
    _dataTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_dataTableView];
}

-(void)initBottomView{
    [self.view addSubview:self.bottomView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 2;
    }else if(section == 4){
        return APPDELEGATE.shopCarArray.count;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 4 || indexPath.section == 5) {
        return 60;
    }else{
        return 44;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifier = @"orderAddressCell";
        orderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        [cell setupCellWithAddress:self.address];
        return cell;
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString *identifer = @"sendDataCell";
            sendDataCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:identifer owner:nil options:nil]firstObject];
            }
            [cell setupCell];
            return cell;
        }else{
            static NSString *identifer = @"payWayCell";
            payWayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:identifer owner:nil options:nil]firstObject];
            }
            [cell setupCell];
            return cell;
        }
    }else if(indexPath.section == 2){
        static NSString *identifier = @"billInfoCell";
        billInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        [cell setupCell];
        return cell;
    }else if(indexPath.section == 3){
        static NSString *identifier = @"notesCell";
        notesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        cell.notesField.delegate = self;
        [cell setupCell];
        return cell;
    }else if(indexPath.section == 4){
        static NSString *identifier = @"orderFruitInfoCell";
        orderFruitInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        [cell setupCellWithDic:APPDELEGATE.shopCarArray[indexPath.row]];
        return cell;
    }else{
        static NSString *identifier = @"orderTotalCell";
        orderTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        [cell setupCell];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        chooseReceiverController *chooseVC = [chooseReceiverController new];
        __weak orderViewController *weakSelf = self;
        chooseVC.didReturnAddress = ^(Address *address){
            weakSelf.address = address;
            [weakSelf.dataTableView reloadData];
        };
        [self.navigationController pushViewController:chooseVC animated:YES];
    }
}

#pragma mark - 新增订单接口，完成后前往支付订单页面

-(void)sendAddOrder{

    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setValue:@(APPDELEGATE.userinfo.id) forKey:@"userId"];
    [paraDic setValue:@(1) forKey:@"status"];
    [paraDic setValue:@(APPDELEGATE.mainTabController.totalPrice)forKey:@"goodsPrice"];
    [paraDic setValue:@(10) forKey:@"freight"];
    [paraDic setValue:@(APPDELEGATE.mainTabController.totalPrice+10)forKey:@"totalPrice"];
    [paraDic setValue:@(1) forKey:@"isBill"];
    [paraDic setValue:@(self.address.id) forKey:@"addressId"];
    [paraDic setValue:@(1) forKey:@"paywayId"];
    NSMutableArray *fruitArr = [NSMutableArray array];
    for (NSDictionary *dict in APPDELEGATE.shopCarArray) {
        int fruitId = [dict[@"fruit_id"] intValue];
        int num = [dict[@"fruit_num"] intValue];
        NSDictionary *dict = @{
                               @"fruitId":@(fruitId),
                               @"num":@(num)
                               };
        [fruitArr addObject:dict];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:fruitArr options:NSJSONWritingPrettyPrinted error:nil];
    NSString    *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [paraDic setValue:str forKey:@"lists"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:addOrderUrl parameters:paraDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            NSString *retOrderNO = dict[@"data"];
            [APPDELEGATE.shopCarArray removeAllObjects];
            [APPDELEGATE.shopCarArray writeToFile:APPDELEGATE.shopCarFilePath atomically:YES];
            APPDELEGATE.mainTabController.totalNum = 0;
            APPDELEGATE.mainTabController.totalPrice = 0;
            APPDELEGATE.mainTabController.badgeView.badgeValue =APPDELEGATE.mainTabController.totalNum;
            [paraDic setValue:retOrderNO forKey:@"orderNO"];
            [self pushToOrderpayView:paraDic];
        }else{
            NSLog(@"no");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送接口失败");
    }];
    
}

-(void)pushToOrderpayView:(NSMutableDictionary *)dict{
    orderpayViewController *VC = [orderpayViewController new];
    VC.orderDic = dict;
    [self.navigationController pushViewController:VC animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{

}





@end
