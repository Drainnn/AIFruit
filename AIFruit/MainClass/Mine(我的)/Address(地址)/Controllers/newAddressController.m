//
//  newAddressController.m
//  AIFruit
//
//  Created by Kosne on 16/5/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "newAddressController.h"
#import "receiveUserCell.h"
#import "mobileNOCell.h"
#import "detailAdCell.h"
#import "areaCell.h"
#import "isDefaultCell.h"
#import "saveAdBtnCell.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface newAddressController ()<UITableViewDataSource,UITableViewDelegate>{
    int flag;
}

@property (nonatomic, strong) UITableView *dataTableView;

@property (nonatomic, copy) NSString *receiveUser;
@property (nonatomic, copy) NSString *mobileNO;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *detailAd;
@property (nonatomic, assign) int isDefault;

@end

@implementation newAddressController

-(UITableView *)dataTableView{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _dataTableView.tableFooterView = [UIView new];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
    }
    return _dataTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    flag = 1;
    self.receiveUser = @"";
    self.mobileNO = @"";
    self.area = @"";
    self.detailAd = @"";
    self.isDefault = 0;
    
    
    self.title = @"新增收货地址";
    
    
    
    [self.view addSubview:self.dataTableView ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    __weak newAddressController *weakSelf = self;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *identifier = @"receiveUserCell";
            receiveUserCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.didChangeFieldText = ^(NSString *cont){
                [weakSelf setupReceiveUser:cont];
            };
            return cell;
        }
        else if (indexPath.row == 1){
            static NSString *identifier = @"mobileNOCell";
            mobileNOCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.didChangeFieldText = ^(NSString *cont){
                [weakSelf setupMobileNO:cont];
            };
            return cell;
        }
        else if (indexPath.row == 2){
            static NSString *identifier = @"areaCell";
            areaCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.didChangeFieldText = ^(NSString *cont){
                [weakSelf setupArea:cont];
            };
            
            return cell;
        }
        else if (indexPath.row == 3){
            static NSString *identifier = @"detailAdCell";
            detailAdCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.didChangeFieldText = ^(NSString *cont){
                [weakSelf setupDetailAd:cont];
            };
            return cell;
        }
    }else if (indexPath.section == 1){
        static NSString *identifier = @"isDefaultCell";
        isDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        cell.didValueChange = ^(BOOL value){
            [weakSelf setupIsDefault:value];
        };
        
        return cell;
    }else{
        
        static NSString *identifier = @"saveAdBtnCell";
        saveAdBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        cell.didSaveAddress = ^(){
            [weakSelf saveAddress];
        };
        [cell setupCell];
        return cell;
    }
    return nil;
}

#pragma mark - 输入框回调事件
-(void)setupReceiveUser:(NSString *)cont{
    self.receiveUser = cont;
}
-(void)setupMobileNO:(NSString *)cont{
    self.mobileNO = cont;
}
-(void)setupArea:(NSString *)cont{
    self.area = cont;
}
-(void)setupDetailAd:(NSString *)cont{
    self.detailAd = cont;
}
-(void)setupIsDefault:(BOOL)value{
    if (value) {
        //值为1
        self.isDefault = 1;
    }else{
        self.isDefault = 0;
    }
}

#pragma mark - 保存地址回调
-(void)saveAddress{
    
    if ([@"" isEqualToString:self.receiveUser] || [@"" isEqualToString:self.mobileNO] || [@"" isEqualToString:self.area] || [@"" isEqualToString:self.detailAd]) {
        [self setWarnInfor:@"请填写完整"];
    }else{
        [self sendSaveAddressRequest];
    }
    
    
}

#pragma mark - 发送地址添加接口请求
-(void)sendSaveAddressRequest{
    NSDictionary *para = @{
                           @"userId":@(APPDELEGATE.userinfo.id),
                           @"receiveUser":self.receiveUser,
                           @"isDefault":@(self.isDefault),
                           @"addressArea":self.area,
                           @"detailAD":self.detailAd,
                           @"contact":self.mobileNO
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:addNewAddressUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = [dict valueForKey:@"code"];
        if ([@"200" isEqualToString:code]) {
            flag = 1;
            
            [self setWarnInfor:@"添加成功"];
            [self performSelector:@selector(popVC) withObject:nil afterDelay:1];
            
            
        }else{
            NSLog(@"添加失败");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送请求失败");
        flag ++;
        if (flag < 4) {
            [self sendSaveAddressRequest];
        }
    }];
    
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

-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
