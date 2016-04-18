//
//  commentTopView.h
//  AIFruit
//
//  Created by Kosne on 16/4/18.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starGradeView.h"

@interface commentTopView : UIView

@property (nonatomic, copy) UILabel *label;
@property (nonatomic, copy) UILabel *scoreLabel;
@property (nonatomic, copy) starGradeView *gradeView;
@property (nonatomic, copy) UILabel *greatComment;

-(instancetype)initWithFrame:(CGRect)frame andScore:(double)score andGreatComment:(double)greatComment;

@end
