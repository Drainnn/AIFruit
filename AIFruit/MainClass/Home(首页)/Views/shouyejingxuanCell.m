//
//  shouyejingxuanCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/20.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "shouyejingxuanCell.h"
#import "UIImageView+WebCache.h"
#import "NSURL+AIFruitURL.h"


@implementation shouyejingxuanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithMainImg:(MainImg *)mainImg{
    self.contImgView.layer.borderWidth = 0.5;
    self.contImgView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contImgView sd_setImageWithURL:[NSURL getShouyejingxuanImgUrlWithId:mainImg.fruitId andImgUrl:mainImg.mainImgUrl] placeholderImage:nil];
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundView:[UIView new]];
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    
}

@end
