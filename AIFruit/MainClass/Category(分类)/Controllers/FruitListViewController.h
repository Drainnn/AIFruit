//
//  FruitListViewController.h
//  AIFruit
//
//  Created by Kosne on 16/4/7.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FruitListViewController : UIViewController

@property (nonatomic,strong) UITableView *dataTableView;

@property (nonatomic, assign) int categoryId;

@property (nonatomic, copy) NSString *tableViewTitle;

@property (nonatomic, copy) NSString *categoryName;

@property (nonatomic, copy) NSMutableArray *cateNameArr;


@end
