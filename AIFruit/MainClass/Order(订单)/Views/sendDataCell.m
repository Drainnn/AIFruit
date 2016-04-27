//
//  sendDataCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/24.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "sendDataCell.h"

@implementation sendDataCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupCell{
    self.titleLabel.text = @"配送日期";
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    self.contLabel.text = dateTime;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
}

@end
