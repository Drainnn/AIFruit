//
//  detailtwoCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "detailtwoCell.h"

@implementation detailtwoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithFruit:(detailFruit *)fruit{
    self.guigeLabel.text = @"规格";
    self.contLabel.layer.borderWidth = 0.5;
    self.contLabel.layer.borderColor = themeColor.CGColor;
    self.contLabel.layer.cornerRadius = 5.0;
    self.contLabel.textAlignment = NSTextAlignmentCenter;
    self.contLabel.text = fruit.standard;
}

@end
