//
//  MyAddressInfoCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "MyAddressInfoCell.h"

@implementation MyAddressInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithAdd:(Address *)address{
    self.receiveUser.text = address.receiveUser;
    self.phone.text = address.contact;
    self.detailAddress.text = [NSString stringWithFormat:@"%@%@",address.addressArea,address.detailAD];
    self.iconImgView.image = [UIImage imageNamed:@"icon_address"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}



@end
