//
//  clearSearchCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/19.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "clearSearchCell.h"

@implementation clearSearchCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell{
    [self.clearBtn setTitle:@"清空搜索记录" forState:UIControlStateNormal];
    [self.clearBtn setTitleColor:themeColor forState:UIControlStateNormal];
    [self.clearBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    self.clearBtn.layer.borderColor = themeColor.CGColor;
    self.clearBtn.layer.borderWidth = 1;
    self.clearBtn.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)action:(UIButton *)btn{
    _didclearSearchRecord();
}

@end
