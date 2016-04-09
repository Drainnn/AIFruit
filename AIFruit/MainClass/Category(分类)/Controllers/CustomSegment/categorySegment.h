//
//  categorySegment.h
//  AIFruit
//
//  Created by Kosne on 16/4/7.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol categorySegmentDelegate <NSObject>

@optional
//调用点击标题的代理
-(void)didselectedTitle:(NSInteger)selectedIndex;

@end

@interface categorySegment : UIView

@property (nonatomic,weak) id <categorySegmentDelegate> delegate;

-(void)addTitleBtnWithTitleArray:(NSArray *)titleArr;
-(instancetype)initWithFrame:(CGRect)frame;


@end
