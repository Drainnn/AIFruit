//
//  loginUserHeadInfoCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/26.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "loginUserHeadInfoCell.h"

@implementation loginUserHeadInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupCell{
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"btn-login"] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"" forState:UIControlStateNormal];
    [self setBackgroundColor:UIColorWithRGB(220, 242, 219)];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)action:(UIButton *)btn{
    _tologinView();
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, UIColorWithRGBA(237, 237, 237, 1.0f).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}

@end
