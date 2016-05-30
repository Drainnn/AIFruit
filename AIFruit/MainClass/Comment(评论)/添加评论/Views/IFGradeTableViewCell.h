//
//  IFGradeTableViewCell.h
//  iFruit
//
//  Created by administrator on 15/8/13.
//  Copyright (c) 2015年 gem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFRatingView.h"

@interface IFGradeTableViewCell : UITableViewCell

@property(nonatomic,strong)IFRatingView *ratingView;
@property (nonatomic,assign)float grade;
@property (weak, nonatomic) IBOutlet UILabel *descripeLabel;

@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;

@end
