//
//  detailthreeCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "detailthreeCell.h"

@implementation detailthreeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithFruit:(detailFruit *)fruit{
    self.chandiLabel.text = @"产地";
    self.descrLabel.text = @"上海现货，20：00前完成订单，预计明日送达";
    self.contLabel.text = fruit.area;
}




@end
