//
//  orderBasicInfoCell.h
//  AIFruit
//
//  Created by Kosne on 16/5/11.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetail.h"

@interface orderBasicInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderNOLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *freightLabel;

@property (weak, nonatomic) IBOutlet UILabel *sendTimeLabel;



-(void)setupCellWithOrderDetail:(OrderDetail *)orderDetail;


@end
