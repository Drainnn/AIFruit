//
//  isDefaultCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "isDefaultCell.h"

@implementation isDefaultCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.defaultSwitch addTarget:self action:@selector(action:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)action:(UISwitch *)sender{
    _didValueChange([sender isOn]);
}

@end
