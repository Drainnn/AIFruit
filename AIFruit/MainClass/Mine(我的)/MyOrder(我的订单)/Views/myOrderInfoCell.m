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
    
    if (order.state == 1) {
        [self.stateBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [self.stateBtn addTarget:self action:@selector(toPayAction:) forControlEvents:UIControlEventTouchUpInside];
    }else if(order.state == 2){
        [self.stateBtn setTitle:@"去评价" forState:UIControlStateNormal];
        [self.stateBtn addTarget:self action:@selector(toCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    }else if (order.state == 3){
        [self.stateBtn setTitle:@"已完成" forState:UIControlStateNormal];
    }
    [self.stateBtn.layer setBorderWidth:0.5];
    [self.stateBtn.layer setBorderColor:themeColor.CGColor];
    [self.stateBtn.layer setCornerRadius:2.0];
    [self.stateBtn setTitleColor:themeColor forState:UIControlStateNormal];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)toPayAction:(UIButton *)sender{
    _topayclicked();
}

-(void)toCommentAction:(UIButton *)sender{
    _tocommentclicked();
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
