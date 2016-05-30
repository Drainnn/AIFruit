//
//  AFCommentGradeCell.h
//  AIFruit
//
//  Created by Kosne on 16/5/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFRatingView.h"

@interface AFCommentGradeCell : UITableViewCell

@property(nonatomic,strong)IFRatingView *ratingView;
@property (nonatomic,assign)float grade;

@end
