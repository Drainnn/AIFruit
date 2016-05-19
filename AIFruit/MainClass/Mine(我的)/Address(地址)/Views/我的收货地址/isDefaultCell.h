//
//  isDefaultCell.h
//  AIFruit
//
//  Created by Kosne on 16/5/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidValueChange)(BOOL value);

@interface isDefaultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *defaultSwitch;

@property (nonatomic, copy) DidValueChange didValueChange;

@end
