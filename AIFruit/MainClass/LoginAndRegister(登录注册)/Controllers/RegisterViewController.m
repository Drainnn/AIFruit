//
//  RegisterViewController.m
//  AIFruit
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "RegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>//短信
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = @"注册";
    
    self.confirmButton.layer.cornerRadius = 5;
    self.confirmButton.layer.masksToBounds = YES;
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
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumberTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (!error) {
                NSLog(@"验证成功");
                
                [SMSSDK commitVerificationCode:self.securityTextField.text phoneNumber:self.phoneNumberTextField.text zone:@"86" result:^(NSError *error) {
                    if (!error) {
                        NSLog(@"验证成功");
                    }
                    else
                    {
                        NSLog(@"错误信息:%@",error);
                    }
                }];
                
            }
            else{
                NSLog(@"%@",error);
            }
        }];

    }
}
@end
