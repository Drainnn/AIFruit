//
//  IFGoodsTableViewCell.m
//  iFruit
//
//  Created by administrator on 15/8/12.
//  Copyright (c) 2015年 gem. All rights reserved.
//

#import "IFGoodsTableViewCell.h"
#define imageURL @"http://appifruit.sinaapp.com/iFruit/Home/images/fruits"

@implementation IFGoodsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setGoodsInfo:(NSDictionary *)dic{

    NSString *imgName = [dic valueForKey:@"fruit_mainimage"];
    NSString *goodsId = [dic valueForKey:@"goods_id"];
    NSString *imgUrl = [NSString stringWithFormat:@"%@/%@/%@",imageURL,goodsId,imgName];
    NSURL *url = [[NSURL alloc]initWithString:[imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.goodsImageView.image = [UIImage imageWithData:data];
   
    
    self.goodsNameLabel.text = [dic valueForKey:@"order_name"];
    
    _goodsPriceLabel.font = [UIFont boldSystemFontOfSize:21.0f];
    _goodsPriceLabel.textColor = [UIColor orangeColor];
    
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",[dic valueForKey:@"order_total"]];
}

@end
