//
//  accountInfoCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface accountInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *account1;

@property (weak, nonatomic) IBOutlet UILabel *title1;

@property (weak, nonatomic) IBOutlet UILabel *account2;


@property (weak, nonatomic) IBOutlet UILabel *title2;

-(void)setupCell;

@end
