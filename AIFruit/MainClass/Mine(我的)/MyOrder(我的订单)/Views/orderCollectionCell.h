//
//  orderCollectionCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

-(void)setupCell;

@end
