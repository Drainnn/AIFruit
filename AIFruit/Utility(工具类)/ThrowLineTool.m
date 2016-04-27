//
//  ThrowLineTool.m
//  CoreAnimationTest
//
//  Created by yh on 15/11/13.
//  Copyright © 2015年 yh. All rights reserved.
//

#import "ThrowLineTool.h"

static ThrowLineTool *s_sharedInstance = nil;
@implementation ThrowLineTool

+ (ThrowLineTool *)sharedTool
{
    if (!s_sharedInstance) {
        s_sharedInstance = [[[self class] alloc] init];
    }
    return s_sharedInstance;
}

/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 */
- (void)throwObject:(UIView *)obj from:(CGPoint)start to:(CGPoint)end type:(int)type
{
    self.showingView = obj;
    UIBezierPath *path= [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(start.x, start.y)];
    //三点曲线
    //type=1:水果信息列表从左向右，type=2:详情页面的购物车按钮从右向左
    if (type == 1) {
        [path addCurveToPoint:CGPointMake(end.x+30, end.y+30)
                controlPoint1:CGPointMake(start.x, start.y)
                controlPoint2:CGPointMake(start.x + 240, start.y - 80)];
    }else if (type == 2){
        [path addCurveToPoint:CGPointMake(end.x+40, end.y+40)
                controlPoint1:CGPointMake(start.x, start.y)
                controlPoint2:CGPointMake(start.x - 50, start.y - 10)];
    }
    
//    [UIView animateWithDuration:0.5 animations:^{
//        CGRect rect = obj.frame;
//        rect.size.width += 100;
//        rect.size.height += 100;
//        obj.frame = rect;
//    }];
    [self groupAnimation:path];
}


#pragma mark - 组合动画
-(void)groupAnimation:(UIBezierPath *)path
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.8f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.5f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [self.showingView.layer addAnimation:groups forKey:@"position scale"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationDidFinish)]) {
        [self.delegate performSelector:@selector(animationDidFinish) withObject:nil];
    }
    self.showingView = nil;
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com