//
//  personalInfoCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/26.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "personalInfoCell.h"
#import "AppDelegate.h"

@implementation personalInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithIndex:(NSInteger)index{
    if (index == 1) {
        [self setTitle:@"手机" andCont:APPDELEGATE.userinfo.mobileNo];
    }else if (index == 2) {
        [self setTitle:@"昵称" andCont:APPDELEGATE.userinfo.username];
    }else if (index == 3){
        [self setTitle:@"会员等级" andCont:[NSString stringWithFormat:@"%d",APPDELEGATE.userinfo.grade]];
    }else if (index == 4){
        [self setTitle:@"性别" andCont:@"男"];
    }else if (index == 5){
        [self setTitle:@"生日" andCont:@"生日"];
    }else if (index == 6){
        [self setTitle:@"注册时间" andCont:APPDELEGATE.userinfo.registTime];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

-(void)setTitle:(NSString *)title andCont:(NSString *)cont{
    self.titleLabel.text = title;
    self.contLabel.text = cont;
}

@end
