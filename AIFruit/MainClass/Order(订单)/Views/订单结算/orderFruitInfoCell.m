//
//  orderFruitInfoCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/24.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "orderFruitInfoCell.h"
#import "NSURL+AIFruitURL.h"
#import "UIImageView+WebCache.h"

@implementation orderFruitInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithDic:(NSDictionary *)dict{

    [self.fruitImgView sd_setImageWithURL:[NSURL getMainImgURLWithId:[[dict valueForKey:shopCar_Fruit_Id_Key] intValue] andmainImgUrl:[dict valueForKey:shopCar_Fruit_Img_Key]] placeholderImage:nil];
    
    self.fruitNameLabel.text = [dict valueForKey:shopCar_Fruit_Name_Key];
    self.priceLabel.text = [dict valueForKey:shopCar_Fruit_Price_Key];
    self.numLabel.text = [NSString stringWithFormat:@"x%@",[dict valueForKey:shopCar_Fruit_Num_Key]]    ;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

}

@end
