//
//  chooseReceiverController.h
//  AIFruit
//
//  Created by Kosne on 16/5/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"

typedef void (^DidReturnAddress)(Address *);

@interface chooseReceiverController : UIViewController

@property (nonatomic, copy) DidReturnAddress didReturnAddress;

@end
