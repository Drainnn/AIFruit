//
//  editDefaultAddressCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "editDefaultAddressCell.h"

@implementation editDefaultAddressCell

- (void)awakeFromNib {
    // Initialization code
    [self.defaultSwitch addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithAddress:(Address *)address{
    int isDefault = address.isDefault;
    if (isDefault == 1) {
        [self.defaultSwitch setOn:YES];
    }
}

-(void)changeValue:(UISwitch *)sender{
    _didChangeValue([sender isOn]);
}



@end
