//
//  editDefaultAddressCell.h
//  AIFruit
//
//  Created by Kosne on 16/5/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"

typedef void (^DidChangeValue)(BOOL value);

@interface editDefaultAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *defaultSwitch;

-(void)setupCellWithAddress:(Address *)address;

@property (nonatomic, copy) DidChangeValue didChangeValue;

@end
