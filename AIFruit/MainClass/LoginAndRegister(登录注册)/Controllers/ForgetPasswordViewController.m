//
//  ForgetPasswordViewController.m
//  AIFruit
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetPasswordSecondViewController.h"
#import <SMS_SDK/SMSSDK.h>//短信验证码
@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = @"验证手机";
    
    self.nextStepButton.layer.cornerRadius = 5;
    self.nextStepButton.layer.masksToBounds = YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回
-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 获取验证码
- (IBAction)getSecurityClicked:(UIButton *)sender {
    
    if (self.phoneNumberTextField.text.length == 11) {
        //获取短信验证码
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumberTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (!error) {
                NSLog(@"获取短信验证码成功");
            }
            else{
                NSLog(@"错误信息:%@",error);
            }
        }];

    }
    
}
#pragma mark - 下一步
- (IBAction)nextStepClicked:(UIButton *)sender {
    if (self.phoneNumberTextField.text.length == 11 && self.securityTextField.text.length == 4) {
        
        [SMSSDK commitVerificationCode:self.securityTextField.text phoneNumber:self.phoneNumberTextField.text zone:@"86" result:^(NSError *error) {
            if (!error) {
                NSLog(@"验证成功");
                
                UIStoryboard *LoginAndRegisterStoryboard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
                ForgetPasswordSecondViewController *vc = [LoginAndRegisterStoryboard instantiateViewControllerWithIdentifier:@"ForgetPasswordSecondVC"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                NSLog(@"错误信息:%@",error);
            }
        }];
        
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneNumberTextField resignFirstResponder];
    [self.securityTextField resignFirstResponder];
}

@end
