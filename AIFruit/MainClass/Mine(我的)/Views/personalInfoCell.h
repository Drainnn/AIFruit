//
//  personalInfoCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/26.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personalInfoCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contLabel;


-(void)setupCellWithIndex:(NSInteger)index;

@end
