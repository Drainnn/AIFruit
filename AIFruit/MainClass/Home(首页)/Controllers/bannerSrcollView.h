//
//  bannerSrcollView.h
//  AIFruit
//
//  Created by Kosne on 16/3/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bannerSrcollView : UIView


/** 占位图 **/
@property (nonatomic, strong) UIImage *placeholderImage;

/** 延迟时间 **/
@property (nonatomic, assign) NSTimeInterval scrollDelayTime;

-(instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray *)imageArray;

@end
