//
//  orderAddressCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/24.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "orderAddressCell.h"

@implementation orderAddressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithAddress:(Address *)address{
    self.nameLabel.text = address.receiveUser;
    self.phoneLabel.text = address.contact;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@",address.addressArea,address.detailAD];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

-(void)setupCellWithOrderDetail:(OrderDetail *)orderDetail{
    self.nameLabel.text = orderDetail.receiveUser;
    self.phoneLabel.text = orderDetail.contact;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@",orderDetail.addressArea,orderDetail.detailAD];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
