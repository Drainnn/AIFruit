//
//  myOrderInfoCell.m
//  AIFruit
//
//  Created by Kosne on 16/5/10.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "myOrderInfoCell.h"
#import "UIImageView+WebCache.h"
#import "NSURL+AIFruitURL.h"

#define WIDTH_IMGVIEW 64
#define HEIGHT_IMGVIEW 60

@implementation myOrderInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithOrder:(Order *)order{
    self.titleLabel.text = @"订单流水号:";
    self.orderNOLabel.text = order.orderNO;
    self.statusLabel.text = order.status;
    self.statusLabel.textColor = themeColor;
    self.timeLabel.text = order.addTime;
    self.payPriceLabel.text = [NSString stringWithFormat:@"实付：￥%d.0",order.totalPrice];
    
    NSArray *imgArr = [NSArray arrayWithArray:order.imgUrls];
    for (int i = 0; i < imgArr.count; i++ ) {
        NSDictionary *dict = imgArr[i];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*WIDTH_IMGVIEW, 0, WIDTH_IMGVIEW, HEIGHT_IMGVIEW)];
        NSString *str = dict[@"fruitId"];
        int id = str.intValue;
        [imgView sd_setImageWithURL:[NSURL getMainImgURLWithId:id andmainImgUrl:dict[@"mainImgUrl"]] placeholderImage:nil];
        [self.ImgScrollView addSubview:imgView];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
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
