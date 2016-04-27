//
//  mimeItemCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/26.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mimeItemCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *bgLabel;
@property (nonatomic, strong) UIImageView *ItemImageView;
@property (nonatomic, strong) UILabel *titleLabel;

-(void)setupCellWithIndex:(NSInteger)index;

@end
