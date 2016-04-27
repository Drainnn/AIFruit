//
//  loginUserHeadInfoCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/26.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ToLoginView)();

@interface loginUserHeadInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (copy, nonatomic) ToLoginView tologinView;

-(void)setupCell;

@end
