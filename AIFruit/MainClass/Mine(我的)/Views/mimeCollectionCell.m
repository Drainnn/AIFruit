//
//  mimeCollectionCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/26.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "mimeCollectionCell.h"

@interface mimeCollectionCell ()<UICollectionViewDelegateFlowLayout>

@end

@implementation mimeCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupCell{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.dataCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.dataCollectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.dataCollectionView];
}

@end
