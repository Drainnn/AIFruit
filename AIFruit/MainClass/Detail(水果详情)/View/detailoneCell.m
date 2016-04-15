//
//  detailoneCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "detailoneCell.h"

@implementation detailoneCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithFruit:(detailFruit *)fruit{
    self.fruitDesc.text = fruit.fruitName;
    NSString *privilStr = [NSString stringWithFormat:@"￥%.1f",fruit.privilegePrice];
    NSMutableAttributedString *privilAttr = [[NSMutableAttributedString alloc]initWithString:privilStr];
    UIFont *font = [UIFont systemFontOfSize:12];
    [privilAttr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, 1)];
    self.privilPrice.attributedText = privilAttr;
    self.privilPrice.textColor = UIColorWithRGB(242, 34, 72);
    self.originPrice.text = [NSString stringWithFormat:@"%.1f",fruit.originPrice];
}

@end
