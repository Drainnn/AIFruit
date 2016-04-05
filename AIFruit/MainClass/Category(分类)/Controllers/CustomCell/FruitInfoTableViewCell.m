//
//  FruitInfoTableViewCell.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "FruitInfoTableViewCell.h"

@implementation FruitInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupCellWithFruitList:(FruitList *)list{
    self.FruitNameLabel.text = list.fruitName;
    self.OriginPriceLabel.text = [NSString stringWithFormat:@"%.1f",list.originPrice];
    self.standardLabel.text = list.standard;
}

@end
