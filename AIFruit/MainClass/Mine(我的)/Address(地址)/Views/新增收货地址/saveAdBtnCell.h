//
//  saveAdBtnCell.h
//  AIFruit
//
//  Created by Kosne on 16/5/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSaveAddress)();

@interface saveAdBtnCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic, copy) DidSaveAddress didSaveAddress;

-(void)setupCell;

@end
