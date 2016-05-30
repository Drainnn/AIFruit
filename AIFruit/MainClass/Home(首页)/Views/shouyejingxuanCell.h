//
//  shouyejingxuanCell.h
//  AIFruit
//
//  Created by Kosne on 16/5/20.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainImg.h"

@interface shouyejingxuanCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *contBtn;

@property (weak, nonatomic) IBOutlet UIImageView *contImgView;


-(void)setupCellWithMainImg:(MainImg *)mainImg;


@end
