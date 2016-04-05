//
//  bannerViewCell.m
//  AIFruit
//
//  Created by Kosne on 16/3/28.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "bannerViewCell.h"
#import "bannerSrcollView.h"

@implementation bannerViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithImages:(NSArray *)imgArr{
    bannerSrcollView *instantScrollView = [[bannerSrcollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 132) WithImages:imgArr];
    instantScrollView.scrollDelayTime = 2;
    _scrollView = (UIScrollView *)instantScrollView;
    
    [self addSubview:instantScrollView];
}


@end
