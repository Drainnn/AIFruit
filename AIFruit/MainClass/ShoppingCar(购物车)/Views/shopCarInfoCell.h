//
//  shopCarInfoCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/21.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopCarInfoCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *increaseBtn;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) NSMutableDictionary *dict;
@property (assign, nonatomic) NSInteger index;

-(void)setupCell;

@end
