//
//  ForgetPasswordViewController.h
//  AIFruit
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *securityTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (weak, nonatomic) IBOutlet UIButton *getSecurityButton;


@end
