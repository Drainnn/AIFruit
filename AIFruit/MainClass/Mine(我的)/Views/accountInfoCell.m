//
//  accountInfoCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "accountInfoCell.h"
#import "AppDelegate.h"

@implementation accountInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell{
    self.account1.text = [NSString stringWithFormat:@"%d",APPDELEGATE.userinfo.currentPoint];
    self.title1.text = @"积分";
    self.account2.text = [NSString stringWithFormat:@"%d",APPDELEGATE.userinfo.allPoint];
    self.title2.text = @"账户余额";
    [self.account1 setTextColor:themeColor];
    [self.account2 setTextColor:themeColor];
    [self.title1 setTextColor:themeColor];
    [self.title2 setTextColor:themeColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self_screen_width/2, 10, 1, 30)];
    [label setBackgroundColor: UIColorWithRGB(237, 237, 237)];
    [self addSubview:label];
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
