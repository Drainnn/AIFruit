//
//  editAddressBtnCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/28.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "editAddressBtnCell.h"

@implementation editAddressBtnCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell{
    [self.deleteBtn setTitle:@"删除地址" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:themeColor forState:UIControlStateNormal];
    self.deleteBtn.layer.cornerRadius = 10;
    self.deleteBtn.layer.borderColor = themeColor.CGColor;
    self.deleteBtn.layer.borderWidth =0.5;
    self.deleteBtn.tag = 50;
    [self.deleteBtn addTarget:self action:@selector(didClickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveBtn.layer.cornerRadius = 10;
    [self.saveBtn setBackgroundColor:themeColor];
    self.saveBtn.tag = 51;
    [self.saveBtn addTarget:self action:@selector(didClickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)didClickSaveBtn:(UIButton *)sender{
    _didClickSaveBtn();
}

-(void)didClickDeleteBtn:(UIButton *)sender{
    _didclickDeleteBtn();
}

@end
