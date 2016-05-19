//
//  chooseAddressEditSaveCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "chooseAddressEditSaveCell.h"

@implementation chooseAddressEditSaveCell

- (void)awakeFromNib {
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:themeColor forState:UIControlStateNormal];
    self.saveBtn.layer.cornerRadius = 5;

    self.saveBtn.layer.borderWidth = 1.0;
    self.saveBtn.layer.borderColor = themeColor.CGColor;
    [self.saveBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)btnAction:(UIButton *)sender{
    _didBtnClicked();
}

@end
