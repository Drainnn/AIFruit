//
//  RegisterViewController.m
//  AIFruit
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "RegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>//短信
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface RegisterViewController (){
    int sendFlag;//发送验证码标识
    int flag;//发送接口标识
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sendFlag = 0;
    flag = 1;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = @"注册";
    
    self.confirmButton.layer.cornerRadius = 5;
    self.confirmButton.layer.masksToBounds = YES;
    
   
}

#pragma mark - 发送验证用户请求接口
-(void)sendVerifyUserRequest{
    NSDictionary *para = @{
                           @"mobileNO":self.phoneNumberTextField.text
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:verifyUserUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            flag = 1;
            [self setWarnInfor:@"该用户已注册"];
        }else if([@"500" isEqualToString:code]){
            
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumberTextField.text zone:@"86"customIdentifier:nil result:^(NSError *error) {
                if (!error) {
                    sendFlag = 1;
                    [self setWarnInfor:@"验证码已发送"];
                    
                }
                else{
                    [self setWarnInfor:[NSString stringWithFormat:@"%@",error]];
                    NSLog(@"%@",error);
                }
            }];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送请求失败");
        if (flag < 4) {
            flag++;
            [self sendVerifyUserRequest];
        }
    }];
}

#pragma mark - 发送注册接口请求
-(void)sendRegisterRequest{
    NSDictionary *para = @{
                           @"mobileNO":self.phoneNumberTextField.text,
                           @"password":self.firstPasswordTextField.text
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:doRegisterUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            
            flag = 1;
            [self setWarnInfor:@"注册成功"];
            [self performSelector:@selector(popView) withObject:nil afterDelay:1.5];
        }else{
            NSLog(@"请求结果错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (flag < 4) {
            flag ++;
            [self sendRegisterRequest];
        }
        NSLog(@"发送请求接口失败");
    }];
}

-(void)popView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 返回
-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 确定
- (IBAction)confirmClicked:(UIButton *)sender {
    
    if ([@"" isEqualToString:self.phoneNumberTextField.text]) {
        [self setWarnInfor:@"请输入手机号码"];
        return;
    }else if (self.phoneNumberTextField.text.length < 11){
        [self setWarnInfor:@"手机号码不正确"];
        return;
    }else if (self.firstPasswordTextField.text.length == 0){
        [self setWarnInfor:@"密码不能为空"];
        return;
    }else if (self.secondPasswordTextField.text.length == 0){
        [self setWarnInfor:@"确认密码不能为空"];
        return;
    }else if (![self.firstPasswordTextField.text isEqualToString:self.secondPasswordTextField.text]){
        [self setWarnInfor:@"两次密码不一致"];
        self.secondPasswordTextField.text = @"";
        return;
    }

    if (sendFlag == 1) {
//        sendFlag = 0;
        [SMSSDK commitVerificationCode:self.securityTextField.text phoneNumber:self.phoneNumberTextField.text zone:@"86" result:^(NSError *error) {
            if (!error) {
                [self sendRegisterRequest];
            }
            else
            {
                [self setWarnInfor:@"验证码不正确"];
            }
        }];
    }else{
        [self setWarnInfor:@"请验证手机号"];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneNumberTextField resignFirstResponder];
    [self.firstPasswordTextField resignFirstResponder];
    [self.secondPasswordTextField resignFirstResponder];
    [self.securityTextField resignFirstResponder];
}
#pragma mark -获取验证码
- (IBAction)getSecurityClicked:(UIButton *)sender {
    if (self.phoneNumberTextField.text.length == 11) {
        
        [self sendVerifyUserRequest];
    
    }else{
        [self setWarnInfor:@"手机号码不正确"];
    }
}

-(void)setWarnInfor:(NSString *)info{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = info;
    hud.color = [UIColor grayColor];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}


@end
