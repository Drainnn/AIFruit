//
//  CategoryInfoTableViewCell.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "CategoryInfoTableViewCell.h"
#import "CategoryList.h"
#import "UIImageView+WebCache.h"

@implementation CategoryInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
   

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCellWithCategoryList:(CategoryList *)list{
    _categoryDetailNameLabel.text = list.detailName;
    _categoryNameLabel.text = list.cateName;
    
//    CGSize itemSize = CGSizeMake(70, 60);
//    
//    UIGraphicsBeginImageContext(itemSize);
//    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
//    
//    [_categoryImgView.image drawInRect:imageRect];
//    
//    _categoryImgView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    NSString *imgStr = [NSString stringWithFormat:@"%@%@",categoryImgUrlPrefix,list.iconName];
    NSURL *url = [[NSURL alloc]initWithString:[imgStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_categoryImgView sd_setImageWithURL:url placeholderImage:nil];
    
}

@end
