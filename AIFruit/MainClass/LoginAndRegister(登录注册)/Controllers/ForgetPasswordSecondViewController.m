//
//  ForgetPasswordSecondViewController.m
//  AIFruit
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "ForgetPasswordSecondViewController.h"

@interface ForgetPasswordSecondViewController ()

@end

@implementation ForgetPasswordSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = @"重置密码";
    
    self.confirmButton.layer.cornerRadius = 5;
    self.confirmButton.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 确定
- (IBAction)confirmClicked:(UIButton *)sender {
}
#pragma mark - 返回
-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.firstPasswordTextField resignFirstResponder];
    [self.secondPasswordTextField resignFirstResponder];
}
@end
