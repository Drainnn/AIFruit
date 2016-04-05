//
//  LoginAndRegisterViewController.h
//  AIFruit
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginAndRegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end
