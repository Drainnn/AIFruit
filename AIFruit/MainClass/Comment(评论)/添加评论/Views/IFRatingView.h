//
//  IFRatingView.h
//  iFruit
//
//  Created by administrator on 15/7/31.
//  Copyright (c) 2015年 gem. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IFRatingView;

@protocol FlowerRatingViewDelegate <NSObject>

@optional
-(void)flowerRatingView:(IFRatingView *)view grade:(float)grade;

@end


@interface IFRatingView : UIView

@property (nonatomic, readonly) int numberOfFlower;

@property (nonatomic, weak) id <FlowerRatingViewDelegate> delegate;

/**
 *  初始化
 */
-(id)initWithFrame:(CGRect)frame numberOfFlower:(int)number;

-(void)setGrade:(float)grade withAnimation:(BOOL)isAnimation;

-(void)setGrade:(float)grade withAnimation:(BOOL)isAnimation completion:
(void (^)(BOOL finished)) completion;
-(void)changeFlowerForegroundViewWithPoint:(CGPoint)point;
@end
