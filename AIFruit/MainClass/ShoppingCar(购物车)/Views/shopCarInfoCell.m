//
//  shopCarInfoCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/21.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "shopCarInfoCell.h"
#import "AppDelegate.h"
#import "NSURL+AIFruitURL.h"
#import "UIImageView+WebCache.h"

@implementation shopCarInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell{
    
    //水果名label
    self.nameLabel.text = [self.dict valueForKey:shopCar_Fruit_Name_Key];
    //数量label
    self.numLabel.text = [self.dict valueForKey:shopCar_Fruit_Num_Key];
    //价格label
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",[self.dict valueForKey:shopCar_Fruit_Price_Key]];
    //图片
    int id = [[self.dict valueForKey:shopCar_Fruit_Id_Key]intValue];
    NSString *imgUrl = [self.dict valueForKey:shopCar_Fruit_Img_Key];
    [self.imgView sd_setImageWithURL:[NSURL getImgURLWithId:id andmainImgUrl:imgUrl] placeholderImage:nil];
    
    self.reduceBtn.layer.cornerRadius = 13;
    self.reduceBtn.layer.borderWidth = 1.0;
    self.reduceBtn.layer.borderColor = themeColor.CGColor;
    [self.reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [self.reduceBtn setTitleColor:themeColor forState:UIControlStateNormal];
    [self.reduceBtn addTarget:self action:@selector(didClickReduceBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.increaseBtn.layer.cornerRadius = 13;
    self.increaseBtn.layer.borderWidth = 1.0;
    self.increaseBtn.layer.borderColor = themeColor.CGColor;
    [self.increaseBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.increaseBtn setTitleColor:themeColor forState:UIControlStateNormal];
    [self.increaseBtn addTarget:self action:@selector(didClickIncreaseBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - 增加btn事件
-(void)didClickIncreaseBtn:(UIButton*)btn{
    int num = self.numLabel.text.intValue;
    [self modifiedNum:num WithType:1];
}

#pragma mark - 减少btn事件
-(void)didClickReduceBtn:(UIButton *)btn{
    int num = self.numLabel.text.intValue;
    if (num > 1) {
        [self modifiedNum:num WithType:2];
    }
    
}

-(void)modifiedNum:(int)num WithType:(int)type{
    //type=1增加，type=2为减少
    if (type == 1) {
        num++;
        APPDELEGATE.mainTabController.totalNum++;
        APPDELEGATE.mainTabController.badgeView.badgeValue ++;
        int price = [[self.dict valueForKey:shopCar_Fruit_Price_Key]intValue];
        APPDELEGATE.mainTabController.totalPrice += price;
    }else{
        num--;
        APPDELEGATE.mainTabController.totalNum --;
        APPDELEGATE.mainTabController.badgeView.badgeValue --;
        int price = [[self.dict valueForKey:shopCar_Fruit_Price_Key]intValue];
        APPDELEGATE.mainTabController.totalPrice -= price;
    }
    //修改cell单个数量
    NSString *numStr = [NSString stringWithFormat:@"%d",num];
    self.numLabel.text = numStr;
    //取到数组里面对应的dictionary
    NSMutableDictionary *dict = APPDELEGATE.shopCarArray[self.index];
    [dict setObject:numStr forKey:shopCar_Fruit_Num_Key];
    [APPDELEGATE.shopCarArray writeToFile:APPDELEGATE.shopCarFilePath atomically:YES];
    
    NSString *totalNumStr = [NSString stringWithFormat:@"%d",APPDELEGATE.mainTabController.totalNum];
    NSString *totalPriceStr = [NSString stringWithFormat:@"￥%d",APPDELEGATE.mainTabController.totalPrice];
    //发送通知
    NSNotification *notice = [NSNotification notificationWithName:numChangeFromBtn object:nil userInfo:@{@"totalNum":totalNumStr,@"totalPrice":totalPriceStr}];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
}




@end
