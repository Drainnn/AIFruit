//
//  saveAdBtnCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "saveAdBtnCell.h"

@implementation saveAdBtnCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell{
    [self.saveBtn.layer setBorderWidth:1.0];
    [self.saveBtn.layer setBorderColor:themeColor.CGColor];
    [self.saveBtn.layer setCornerRadius:5.0];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:themeColor forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveAddress:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)saveAddress:(UIButton *)sender{
    _didSaveAddress();
}

@end
