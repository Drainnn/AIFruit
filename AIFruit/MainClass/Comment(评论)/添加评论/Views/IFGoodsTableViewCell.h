//
//  IFGoodsTableViewCell.h
//  iFruit
//
//  Created by administrator on 15/8/12.
//  Copyright (c) 2015年 gem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFGoodsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

-(void)setGoodsInfo:(NSDictionary *)dic;

@end
