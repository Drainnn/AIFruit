//
//  BadgeView.m
//  AIFruit
//
//  Created by Kosne on 16/4/20.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "BadgeView.h"

@implementation BadgeView

-(instancetype)initWithFrame:(CGRect)frame WithString:(NSString *)string{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        CGFloat width = frame.size.width;
        int value = string.intValue;
        //如果值大于10，增加View的宽度
        if (value > 10) {
            width += 5;
            frame.size.width = width;
            self.frame = frame;
        }
        self.layer.cornerRadius = frame.size.height / 2;
        self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.textLabel.font = UIFontWithSize(12);
        [self.textLabel setTextColor:[UIColor whiteColor]];
        self.textLabel.text = string;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textLabel];
        self.badgeStr = string;
    }
    return self;
}


- (void)setBadgeValue:(int)badgeValue {
    _badgeValue = badgeValue;
    if (badgeValue == 0) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
        self.textLabel.text = [NSString stringWithFormat:@"%d",badgeValue];
    }
    
   
}

@end
