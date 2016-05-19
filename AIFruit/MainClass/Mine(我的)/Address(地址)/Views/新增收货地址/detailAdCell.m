//
//  detailAdCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "detailAdCell.h"

@interface detailAdCell ()<UITextFieldDelegate>

@end

@implementation detailAdCell

- (void)awakeFromNib {
    // Initialization code
     [self.contField addTarget:self action:@selector(TextFieldChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)TextFieldChange:(UITextField *)sender{
    _didChangeFieldText(sender.text);
}

@end
