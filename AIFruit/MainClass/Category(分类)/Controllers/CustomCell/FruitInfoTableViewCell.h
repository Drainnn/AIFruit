//
//  FruitInfoTableViewCell.h
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FruitList.h"

@interface FruitInfoTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *FruitNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *OriginPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *standardLabel;

-(void)setupCellWithFruitList:(FruitList *)list;

@end
