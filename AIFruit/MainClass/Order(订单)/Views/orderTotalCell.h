//
//  orderTotalCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/24.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderTotalCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *shangpinzonge;

@property (weak, nonatomic) IBOutlet UILabel *yunfei;


@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *yunfeiPriceLabel;


-(void)setupCell;

@end
