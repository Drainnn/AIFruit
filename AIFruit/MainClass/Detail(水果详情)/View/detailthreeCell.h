//
//  detailthreeCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailFruit.h"

@interface detailthreeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *chandiLabel;

@property (weak, nonatomic) IBOutlet UILabel *contLabel;

@property (weak, nonatomic) IBOutlet UILabel *descrLabel;

-(void)setupCellWithFruit:(detailFruit *)fruit;

@end
