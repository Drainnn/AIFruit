//
//  LoginAndRegisterViewController.m
//  AIFruit
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#import "PrefixHeader.pch"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "UserInfo.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"

@interface LoginAndRegisterViewController (){
    int flag;
}

@property (nonatomic, strong) UserInfo *userinfo;
@property (nonatomic, strong) MBProgressHUD *waitHud;

@end

@implementation LoginAndRegisterViewController

-(UserInfo *)userinfo{
    if (!_userinfo) {
        _userinfo = [[UserInfo alloc]init
                     ];
    }
    return _userinfo;
}

-(MBProgressHUD *)waitHud{
    if (!_waitHud) {
        _waitHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    }
    return _waitHud;
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
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;
    
    
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.masksToBounds = YES;
    self.registerButton.layer.borderColor = UIColorWithRGBA(0, 137, 63, 1).CGColor;
    self.registerButton.layer.cornerRadius = 5;
    self.registerButton.layer.masksToBounds = YES;
    [self.registerButton.layer setBorderWidth:1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -忘记密码
- (IBAction)forgetPasswordClicked:(UIButton *)sender {
    UIStoryboard *LoginAndRegisterStoryboard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
    ForgetPasswordViewController *vc = [LoginAndRegisterStoryboard instantiateViewControllerWithIdentifier:@"ForgetPasswordVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -登录
- (IBAction)loginClicked:(UIButton *)sender {
    [self sendDoLoginRequest];
}

-(void)sendDoLoginRequest{
    [self showhud];
    NSDictionary *para = @{
                           @"mobileNo":self.phoneNumberTextField.text,
                           @"password":self.passwordTextField.text
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:doLoginUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        
         [self.waitHud hide:YES];
        
        if ([@"200" isEqualToString:code]) {
            APPDELEGATE.isLogin = 1;
            NSDictionary *dic = dict[@"data"];
            UserInfo *info = [UserInfo objectWithKeyValues:dic];
            self.userinfo = info;
            
            //信息保存本地
            APPDELEGATE.userinfo = self.userinfo;
            [self saveUserInfo:self.userinfo];

            NSNotification *notification = [NSNotification notificationWithName:loginSuccessNotification object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notification];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"用户名或密码错误");
            self.passwordTextField.text = @"";
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"接口请求失败");
        if (flag < 5) {
            flag++;
            [self sendDoLoginRequest];
        }
    }];
}

#pragma mark -立即注册
- (IBAction)registerClicked:(UIButton *)sender {
    
    UIStoryboard *LoginAndRegisterStoryboard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
    RegisterViewController *vc = [LoginAndRegisterStoryboard instantiateViewControllerWithIdentifier:@"RegisterVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneNumberTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark - 信息保存本地
-(void)saveUserInfo:(UserInfo *)userinfo{
    NSMutableData *receiveData = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:receiveData];
    [archiver encodeObject:userinfo forKey:@"user"];
    [archiver finishEncoding];
    [receiveData writeToFile:APPDELEGATE.userInfoFilePath atomically:YES];
}


@end
