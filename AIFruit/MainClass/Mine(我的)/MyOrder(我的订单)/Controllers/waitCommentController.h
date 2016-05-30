//
//  waitCommentController.h
//  AIFruit
//
//  Created by Kosne on 16/5/13.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidToAddComment)(NSMutableArray *,NSInteger);

@interface waitCommentController : UIViewController

@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) DidToAddComment didtoaddcomment;

@end
