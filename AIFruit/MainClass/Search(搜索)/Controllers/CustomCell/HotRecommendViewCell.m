//
//  HotRecommendViewCell.m
//  AIFruit
//
//  Created by Kosne on 16/3/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "HotRecommendViewCell.h"

@implementation HotRecommendViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupCell{
    
    _BtnArr = [NSMutableArray array];
    [_BtnArr addObject:_oneBtn];
    [_BtnArr addObject:_twoBtn];
    [_BtnArr addObject:_threeBtn];
    [_BtnArr addObject:_fourBtn];
    [_BtnArr addObject:_fiveBtn];
    [_BtnArr addObject:_siveBtn];
    [_BtnArr addObject:_sixBtn];
    [_BtnArr addObject:_eightBtn];
    [_BtnArr addObject:_nineBtn];
    NSInteger length = _BtnArr.count;
    for (int i = 0; i < length; i++) {

        UIButton *btn = [_BtnArr objectAtIndex:i];
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [btn setBackgroundColor:UIColorWithRGBA(255, 255, 255, 1)];
        [btn.layer setBorderWidth:1.0];
        [btn.layer setBorderColor:UIColorWithRGBA(220, 225, 227, 1).CGColor];
        [btn.layer setCornerRadius:4];
    }
    

    
}

@end
