//
//  IFRatingView.m
//  iFruit
//
//  Created by administrator on 15/7/31.
//  Copyright (c) 2015年 gem. All rights reserved.
//

#import "IFRatingView.h"
//#define KBACKGRROUND_FLOWER @"comm_grade"
//#define KFOREDGROUND_FLOWER @"comm_gradeRed"
#define KBACKGRROUND_FLOWER @"stardefault"
#define KFOREDGROUND_FLOWER @"starlight"

@interface IFRatingView  ()

@property (nonatomic, strong) UIView *flowerBackgroundView;
@property (nonatomic, strong) UIView *flowerForegroundView;

@end

@implementation IFRatingView

-(instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfFlower:5];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _numberOfFlower = 5;
    [self commonInit];
}


/**
 *  初始化
 */
-(id)initWithFrame:(CGRect)frame numberOfFlower:(int)number
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfFlower = number;
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
    self.flowerBackgroundView = [self buildFlowerViewWithImageName:KBACKGRROUND_FLOWER];
    self.flowerForegroundView = [self buildFlowerViewWithImageName:KFOREDGROUND_FLOWER];
    self.flowerForegroundView.frame = CGRectMake(0, 0, 50, self.frame.size.height);
    [self addSubview:self.flowerBackgroundView];
    [self addSubview:self.flowerForegroundView];
}



-(void)setGrade:(float)grade withAnimation:(BOOL)isAnimation
{
    [self setGrade:grade withAnimation:isAnimation completion:^(BOOL finished) {
        
    }];
}


-(void)setGrade:(float)grade withAnimation:(BOOL)isAnimation completion:(void (^)(BOOL))completion
{
    NSAssert((grade>=0.0)&&(grade<=1.0), @"必须大于0小于1");
    if (grade<0) {
        grade = 0;
    }
    
    if (grade>1.0) {
        grade = 1.0;
    }
    
    CGPoint point = CGPointMake(grade * self.frame.size.width, 0);
    
    if (isAnimation) {
        __weak __typeof(self)weakSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            [weakSelf changeFlowerForegroundViewWithPoint:point];
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
    }
    else{
        [self changeFlowerForegroundViewWithPoint:point];
    }
}



/**
 *  点击手势滑动
 *
 *  @param touches
 *  @param event
 */
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsPoint(rect, point)) {
        [self changeFlowerForegroundViewWithPoint:point];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak __typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf changeFlowerForegroundViewWithPoint:point];
    }];
}



-(UIView *)buildFlowerViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i <  self.numberOfFlower; i++) {
        UIImageView *imageView = [[ UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i*frame.size.width/self.numberOfFlower, 0, frame.size.width/self.numberOfFlower, frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}


-(void)changeFlowerForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    
    if (p.x < 0) {
        p.x = 0;
    }
    
    if (p.x > self.frame.size.width) {
        p.x = self.frame.size.width;
    }
    
    NSString *str = [NSString stringWithFormat:@"%0.2f",p.x/self.frame.size.width];
    float grade = [str floatValue];
    p.x = grade * self.frame.size.width;
  
    self.flowerForegroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowerRatingView:grade:)]) {
        [self.delegate flowerRatingView:self grade:grade];
    }
}


@end
