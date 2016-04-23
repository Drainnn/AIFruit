//
//  FruitInfoTableViewCell.h
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FruitList.h"

typedef void (^ToShopCar)();

@interface FruitInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *PrivilegePriceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *FrultImgView;


@property (weak, nonatomic) IBOutlet UILabel *FruitNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *OriginPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *standardLabel;


@property (weak, nonatomic) IBOutlet UILabel *saleNumLabel;

@property (weak, nonatomic) IBOutlet UIButton *toCarBtn;

@property (copy, nonatomic) ToShopCar toShopCar;

@property (strong, nonatomic) FruitList *fruitList;

-(void)setupCellWithFruitList:(FruitList *)list;

@end
