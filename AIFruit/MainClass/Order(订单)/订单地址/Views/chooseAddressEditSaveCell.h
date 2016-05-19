//
//  chooseAddressEditSaveCell.h
//  AIFruit
//
//  Created by Kosne on 16/5/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidBtnClicked)();

@interface chooseAddressEditSaveCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic, copy) DidBtnClicked didBtnClicked;

@end
