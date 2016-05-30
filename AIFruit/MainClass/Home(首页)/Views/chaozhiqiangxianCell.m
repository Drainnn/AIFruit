//
//  chaozhiqiangxianCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/20.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "chaozhiqiangxianCell.h"

@implementation chaozhiqiangxianCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell{
    self.leftBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.leftBtn.layer.borderWidth = 1;
    self.centerBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.centerBtn.layer.borderWidth = 1;
    self.rightBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.rightBtn.layer.borderWidth = 1;
}

@end
