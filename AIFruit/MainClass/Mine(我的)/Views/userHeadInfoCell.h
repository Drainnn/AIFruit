//
//  userHeadInfoCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ToLoginView)();

@interface userHeadInfoCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *loginBtn;

@property (copy, nonatomic) ToLoginView tologinView;

-(void)setupInfoCell;

-(void)setupBtnCell;

@end
