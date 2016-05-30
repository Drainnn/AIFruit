//
//  AFCommentFruitInfoCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "AFCommentFruitInfoCell.h"
#import "NSURL+AIFruitURL.h"
#import "UIImageView+WebCache.h"

@implementation AFCommentFruitInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell:(NSDictionary *)dict{
    self.numLabel.text = [NSString stringWithFormat:@"x%@",dict[@"num"]];;
    self.FruitNameLabel.text = dict[@"fruitName"];
    self.priceLabel.text = [NSString stringWithFormat:@"%@",dict[@"privilegePrice"]];
    
    //图片
    int id = [[NSString stringWithFormat:@"%@",dict[@"fruitId"]]intValue];
    NSString *imgUrl = dict[@"mainImgUrl"];
    [self.imgView sd_setImageWithURL:[NSURL getMainImgURLWithId:id andmainImgUrl:imgUrl] placeholderImage:nil];
}

@end
