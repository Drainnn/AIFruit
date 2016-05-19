//
//  orderAddressCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/24.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
#import "OrderDetail.h"

@interface orderAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


-(void)setupCellWithAddress:(Address *)address;
-(void)setupCellWithOrderDetail:(OrderDetail *)orderDetail;

@end
