//
//  orderTotalCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/24.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "orderTotalCell.h"
#import "AppDelegate.h"

@implementation orderTotalCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell{
    self.shangpinzonge.text = @"商品总额";
    self.yunfei.text = @"运费";
    self.priceLabel.text = [NSString stringWithFormat:@"￥%d.00",APPDELEGATE.mainTabController.totalPrice];
    self.priceLabel.textColor = fruit_red;
    self.yunfeiPriceLabel.text = @"￥10.00";
    self.yunfeiPriceLabel.textColor = fruit_red;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
