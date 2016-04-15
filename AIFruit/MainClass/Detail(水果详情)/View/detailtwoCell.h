//
//  detailtwoCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailFruit.h"

@interface detailtwoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contLabel;

-(void)setupCellWithFruit:(detailFruit *)fruit;

@end
