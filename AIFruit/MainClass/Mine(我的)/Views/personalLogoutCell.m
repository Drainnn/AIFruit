//
//  personalLogoutCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "personalLogoutCell.h"

@implementation personalLogoutCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell{
    [self.logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.logoutBtn setTitleColor:themeColor forState:UIControlStateNormal];
    self.logoutBtn.layer.cornerRadius = 5;
    self.logoutBtn.layer.borderWidth = 0.5;
    self.logoutBtn.layer.borderColor = themeColor.CGColor;
    [self.logoutBtn addTarget:self  action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)action:(UIButton *)btn{
    _didlogoutBtn();
}

@end
