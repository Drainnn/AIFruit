//
//  mimeCollectionCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/26.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mimeCollectionCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *dataCollectionView;

-(void)setupCell;

@end
