//
//  notesCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/24.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "notesCell.h"

@implementation notesCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell{
    self.notesField.placeholder = @"若您对订单有特殊要求，请在此填写备注";
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
