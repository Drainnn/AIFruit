//
//  FruitInfoTableViewCell.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "FruitInfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+AIFruitString.h"
#import "NSURL+AIFruitURL.h"

@implementation FruitInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//设置cell内容
-(void)setupCellWithFruitList:(FruitList *)list{
    
    self.fruitList = list;
    
    //图片
    [self.FrultImgView sd_setImageWithURL:[NSURL getImgURLWithId:list.id andmainImgUrl:list.mainImgUrl] placeholderImage:nil];
    self.FrultImgView.layer.cornerRadius = 5.0;
    self.FrultImgView.layer.borderColor = [UIColorWithRGBA(233, 234, 237, 1.0f) CGColor];
    self.FrultImgView.layer.borderWidth = 0.5f;
    
    //水果名
    self.FruitNameLabel.text = list.fruitName;
    
    //规格
    self.standardLabel.text = list.standard;
    
    //原价
    self.OriginPriceLabel.attributedText = [NSString setOriginPriceWithPrice:list.originPrice];
    
    //优惠价格
    NSString *privilegePriceStr = [NSString stringWithFormat:@"￥%.1f",list.privilegePrice];
    NSMutableAttributedString *privilAttStr = [[NSMutableAttributedString alloc]initWithString:privilegePriceStr];
    //修改富文本中的不同文字的样式
    UIFont *f1 = UIFontWithSize(19);
    [privilAttStr addAttribute:NSFontAttributeName value:f1 range:NSMakeRange(0, 3)];
    self.PrivilegePriceLabel.attributedText = privilAttStr;
    //销售数量
    self.saleNumLabel.text = [NSString stringWithFormat:@"已售：%d",list.saleNum];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //添加购物车按钮
//    [self.toCarBtn setTitle:@"你好" forState:UIControlStateNormal];
//    [self.toCarBtn setImage:[UIImage imageNamed:@"shopCar"] forState:UIControlStateNormal];
    
    [self.toCarBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)action:(UIButton *)btn{
    _toShopCar();
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
