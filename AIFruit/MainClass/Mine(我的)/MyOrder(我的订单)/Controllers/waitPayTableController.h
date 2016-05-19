//
//  waitPayTableController.h
//  AIFruit
//
//  Created by Kosne on 16/5/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

typedef void (^DidToOrderDetail)(Order *);

@interface waitPayTableController : UIViewController

@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) DidToOrderDetail didToOrderDetail;

@end
