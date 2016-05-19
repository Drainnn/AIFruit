//
//  chooseReceiverCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "chooseReceiverCell.h"

@interface chooseReceiverCell (){
    Address *self_address;
}

@end

@implementation chooseReceiverCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithAddress:(Address *)address{
    self_address = address;
    self.receiverLabel.text = address.receiveUser;
    self.mobileNoLabel.text = address.contact;
    self.detailADLabel.text = address.detailAD;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.toDetailBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.flagLabel.layer.borderWidth = 1.0;
    self.flagLabel.layer.cornerRadius = 2.0;
    self.flagLabel.textAlignment = NSTextAlignmentCenter;
    if (address.isDefault == 1) {
        self.flagLabel.text = @"默认";
        [self.flagLabel setBackgroundColor:themeColor];
        [self.flagLabel setTextColor:[UIColor whiteColor]];
    }else{
        self.flagLabel.text = @"地址";
        self.flagLabel.layer.borderColor = themeColor.CGColor;
        [self.flagLabel setTextColor:themeColor];
    }
}

-(void)btnAction:(UIButton *)sender{
    _didBtnClicked(self_address);
}

@end
