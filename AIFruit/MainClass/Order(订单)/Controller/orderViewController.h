//
//  orderViewController.h
//  AIFruit
//
//  Created by Kosne on 16/4/24.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ShowTabbar)();

@interface orderViewController : UIViewController

@property (nonatomic, copy) ShowTabbar showTabbar;

@end
