//
//  FruitInfoTableViewCell.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "FruitInfoTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation FruitInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupCellWithFruitList:(FruitList *)list{
    
    NSString *imgStr = [NSString stringWithFormat:@"%@/%@/%@",mainImgUrlPrefix,[NSString stringWithFormat:@"%d",list.id],list.mainImgUrl];
    NSURL *url = [[NSURL alloc]initWithString:[imgStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [self.FrultImgView sd_setImageWithURL:url placeholderImage:nil];
    CALayer * layer = [self.FrultImgView layer];
    [layer setCornerRadius:5.0];
    layer.borderColor = [
                         UIColorWithRGBA(233, 234, 237, 1.0f) CGColor];
    layer.borderWidth = 0.5f;
    self.FruitNameLabel.text = list.fruitName;
    NSString *originPriceStr = [NSString stringWithFormat:@"￥%.1f",list.originPrice];
    
    self.standardLabel.text = list.standard;
    NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:originPriceStr attributes:@{NSForegroundColorAttributeName:UIColorWithRGBA(187, 54, 8, 1.0f),NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSStrikethroughColorAttributeName:UIColorWithRGBA(187, 54, 8, 1.0f)}];
    self.OriginPriceLabel.attributedText = attStr;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}

@end
