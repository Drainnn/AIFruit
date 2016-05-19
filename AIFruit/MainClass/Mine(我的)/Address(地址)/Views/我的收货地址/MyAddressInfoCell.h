//
//  MyAddressInfoCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"

@interface MyAddressInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *receiveUser;

@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (weak, nonatomic) IBOutlet UILabel *detailAddress;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

-(void)setupCellWithAdd:(Address *)address;


@end
