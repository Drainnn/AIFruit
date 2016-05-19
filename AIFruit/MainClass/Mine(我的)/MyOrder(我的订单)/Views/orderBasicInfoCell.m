//
//  orderBasicInfoCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/11.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "orderBasicInfoCell.h"

@implementation orderBasicInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupCellWithOrderDetail:(OrderDetail *)orderDetail{
    self.orderNOLabel.text = orderDetail.orderNO;
    self.orderStatusLabel.text = orderDetail.status;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%d.00",orderDetail.totalPrice];
    self.freightLabel.text = [NSString stringWithFormat:@"￥%d",orderDetail.freight];
    self.sendTimeLabel.text = orderDetail.sendTime;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
