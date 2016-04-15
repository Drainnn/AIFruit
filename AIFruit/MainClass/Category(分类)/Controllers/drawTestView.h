//
//  drawTestView.h
//  AIFruit
//
//  Created by Kosne on 16/4/6.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface drawTestView : UIView


-(instancetype)initWithFrame:(CGRect)frame andCount:(NSInteger)count;
-(void)setupViewWithArray:(NSArray *)cateNameArr;
@end
