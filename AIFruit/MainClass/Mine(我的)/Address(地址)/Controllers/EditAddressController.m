//
//  EditAddressController.m
//  AIFruit
//
//  Created by Kosne on 16/4/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "EditAddressController.h"
#import "editAddressInfoCell.h"
#import "editAddressBtnCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "editDefaultAddressCell.h"

@interface EditAddressController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    int flag;
}

@property (nonatomic, copy) NSString *receiveUser;
@property (nonatomic, copy) NSString *mobileNO;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *detailAd;
@property (nonatomic, assign) int isDefault;

@property (nonatomic, strong) UITableView *dataTableView;

@end

@implementation EditAddressController

-(UITableView *)dataTableView{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _dataTableView.tableFooterView = [UIView new];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.sectionHeaderHeight = 0.1;
        _dataTableView.sectionFooterHeight = 5;
        _dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _dataTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = 1;
    
    self.receiveUser = self.address.receiveUser;
    self.mobileNO = self.address.contact;
    self.area = self.address.addressArea;
    self.detailAd = self.address.detailAD;
    self.isDefault = self.address.isDefault;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;
    self.title = @"编辑收货地址";
    
    [self.view addSubview:self.dataTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else if(section == 1){
        return 1;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     __weak EditAddressController *weakSelf = self;
    if (indexPath.section == 0) {
        static NSString *identifier = @"editAddressInfoCell";
        editAddressInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
       
        [cell setupCellWithAddress:self.address andIndex:indexPath.row];
        cell.didChangeFieldText = ^(NSString *cont,NSInteger index){
            [weakSelf changeAddressValue:cont andIndex:index];
        };
        return cell;
    }else if (indexPath.section == 1){
        static NSString *identifier = @"editDefaultAddressCell";
        editDefaultAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        
        [cell setupCellWithAddress:self.address];
        cell.didChangeValue = ^(BOOL value){
            [weakSelf setupIsDefault:value];
        };
        return cell;
    }else{
        static NSString *identifier = @"editAddressBtnCell";
        editAddressBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        UIView *temp = [[UIView alloc]init];
        [cell setBackgroundView:temp];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setupCell];
        cell.didClickSaveBtn = ^(){
            [weakSelf didClickSaveBtn];
        };
        cell.didclickDeleteBtn = ^(){
            [weakSelf didClickDeleteBtn];
        };
        
        return cell;
    }
  
}

-(void)changeAddressValue:(NSString *)cont andIndex:(NSInteger)index{
    if (index == 0) {
        self.receiveUser = cont;
    }else if (index == 1){
        self.mobileNO = cont;
    }else if (index == 2){
        self.area = cont;
    }else if (index == 3){
        self.detailAd = cont;
    }
}
-(void)setupIsDefault:(BOOL)value{
    if (value) {
        //值为1
        self.isDefault = 1;
    }else{
        self.isDefault = 0;
    }
}

#pragma mark - 删除、保存按钮点击回调
-(void)didClickSaveBtn{
    //保存
    [self sendUpdateAddressRequest];
}

-(void)didClickDeleteBtn{
    //删除
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除该地址吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    [alertView show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self sendDeleteAddressRequest];
    }
}

#pragma mark - 发送删除订单请求
-(void)sendDeleteAddressRequest{
    NSDictionary *para = @{
                           @"id":@(self.address.id)
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:deleteAddressUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            
            [self setWarnInfor:@"已删除"];
            [self performSelector:@selector(popView) withObject:nil afterDelay:1];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送请求失败");
        flag ++;
        if (flag < 4) {
            [self sendDeleteAddressRequest];
        }
    }];
}

#pragma mark - 发送更新地址请求
-(void)sendUpdateAddressRequest{
    NSDictionary *para = @{
                           @"id":@(self.address.id),
                           @"userId":@(APPDELEGATE.userinfo.id),
                           @"receiveUser":self.receiveUser,
                           @"isDefault":@(self.isDefault),
                           @"addressArea":self.area,
                           @"detailAD":self.detailAd,
                           @"contact":self.mobileNO
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:updateAddressUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            
            [self setWarnInfor:@"修改成功"];
            [self performSelector:@selector(popView) withObject:nil afterDelay:1];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送请求失败");
        flag ++;
        if (flag < 4) {
            [self sendUpdateAddressRequest];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setWarnInfor:(NSString *)info{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = info;
    hud.color = [UIColor grayColor];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}
-(void)popView{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
