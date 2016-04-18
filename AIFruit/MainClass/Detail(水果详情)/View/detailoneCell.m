//
//  detailoneCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "detailoneCell.h"
#import "NSString+OriginPriceString.h"

@interface detailoneCell (){
    int num;
}

@end

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
    
    self.originPrice.attributedText = [NSString setOriginPriceWithPrice:fruit.originPrice];
    
    [self.reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [self.reduceBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.reduceBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.increaseBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.increaseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.increaseBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    num = 1;
    self.numLabel.text = [NSString stringWithFormat:@"%d",num];
    self.numLabel.layer.borderWidth = 0.5;
    self.numLabel.layer.borderColor = [[UIColor grayColor]CGColor];
    self.bgLabel.layer.cornerRadius = 4;
    self.bgLabel.layer.borderWidth = 0.5;
    self.bgLabel.layer.borderColor = [[UIColor grayColor]CGColor];
}

-(void)action:(id)sender{
    num ++;
    self.numLabel.text = [NSString stringWithFormat:@"%d",num];
}

@end
