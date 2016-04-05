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
@interface LoginAndRegisterViewController ()

@end

@implementation LoginAndRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
@end
