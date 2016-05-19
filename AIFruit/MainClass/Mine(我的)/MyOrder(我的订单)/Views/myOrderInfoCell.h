//
//  myOrderInfoCell.h
//  AIFruit
//
//  Created by Kosne on 16/5/10.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface myOrderInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderNOLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *borderTopLabel;

@property (weak, nonatomic) IBOutlet UILabel *borderBottomLabel;


@property (weak, nonatomic) IBOutlet UILabel *payPriceLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *ImgScrollView;


-(void)setupCellWithOrder:(Order *)order;

@end
