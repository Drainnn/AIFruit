//
//  detailfourCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailFruit.h"

@interface detailfourCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *greatCommentLabel;

-(void)setupCellWithFruit:(detailFruit *)fruit;

@end
