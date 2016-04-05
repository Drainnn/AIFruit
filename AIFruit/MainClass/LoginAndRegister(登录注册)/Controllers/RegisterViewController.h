//
//  RegisterViewController.h
//  AIFruit
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *securityTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end
