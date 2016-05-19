//
//  orderFruitInfoCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/24.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderFruitInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *fruitImgView;

@property (weak, nonatomic) IBOutlet UILabel *fruitNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

-(void)setupCellWithDic:(NSDictionary *)dict;


@end
