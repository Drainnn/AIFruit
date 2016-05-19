//
//  editAddressInfoCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/28.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"

typedef void (^DidChangeFieldText)(NSString *cont,NSInteger index);

@interface editAddressInfoCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contField;

@property (nonatomic, copy) DidChangeFieldText didChangeFieldText;

-(void)setupCellWithAddress:(Address *)address andIndex:(NSInteger)index;

@end
