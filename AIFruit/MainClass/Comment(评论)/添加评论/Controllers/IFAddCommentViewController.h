//
//  IFAddCommentViewController.h
//  iFruit
//
//  Created by administrator on 15/8/14.
//  Copyright (c) 2015年 gem. All rights reserved.
//




#import <UIKit/UIKit.h>

typedef void (^DidPopView)();

@interface IFAddCommentViewController : UIViewController



@property (nonatomic,strong)NSDictionary *orderDIC;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSString *goodsID;

@property (strong, nonatomic) DidPopView didPopView;

@end
