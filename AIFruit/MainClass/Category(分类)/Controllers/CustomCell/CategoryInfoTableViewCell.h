//
//  CategoryInfoTableViewCell.h
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryList.h"

@interface CategoryInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryDetailNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *categoryImgView;

- (void)setupCellWithCategoryList:(CategoryList *)list;

@end
