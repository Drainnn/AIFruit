//
//  detailoneCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailFruit.h"

@interface detailoneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fruitDesc;

@property (weak, nonatomic) IBOutlet UILabel *privilPrice;

@property (weak, nonatomic) IBOutlet UILabel *originPrice;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;

@property (weak, nonatomic) IBOutlet UIButton *increaseBtn;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;


-(void)setupCellWithFruit:(detailFruit *)fruit;

@end
