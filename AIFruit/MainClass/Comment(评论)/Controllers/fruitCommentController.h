//
//  fruitCommentController.h
//  AIFruit
//
//  Created by Kosne on 16/4/17.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fruitCommentController : UIViewController

@property (nonatomic, strong) UITableView *dataTableView;
//@property (nonatomic, strong) UIView *topView;
@property (nonatomic, assign) int fruitId; //水果id
@property (nonatomic, assign) int commentNum; //评论数量
@property (nonatomic, assign) int totalScore; //总分
@property (nonatomic, assign) double greatComment; //好评率
@end
