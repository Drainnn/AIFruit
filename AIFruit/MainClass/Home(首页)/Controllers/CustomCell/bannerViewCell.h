//
//  bannerViewCell.h
//  AIFruit
//
//  Created by Kosne on 16/3/28.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bannerViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


-(void)setupCellWithImages:(NSArray *)imgArr;

@end
