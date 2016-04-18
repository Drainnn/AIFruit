//
//  commentCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

@interface commentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mobileNoLabel;

@property (weak, nonatomic) IBOutlet UILabel *contLabel;

@property (weak, nonatomic) IBOutlet UILabel *pushTimeLabel;


@property (weak, nonatomic) IBOutlet UIView *gradeView;


-(void)setupCellWithComment:(Comment *)comment;

@end
