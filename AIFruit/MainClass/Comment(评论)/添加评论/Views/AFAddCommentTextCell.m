//
//  AFAddCommentTextCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "AFAddCommentTextCell.h"


@implementation AFAddCommentTextCell

- (void)awakeFromNib {
    [self.commentText addTarget:self action:@selector(TextFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)TextFieldChange:(UITextField *)sender{
    _didCommentText(sender.text);
}



@end
