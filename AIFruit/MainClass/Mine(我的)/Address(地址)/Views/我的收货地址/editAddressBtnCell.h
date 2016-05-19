//
//  editAddressBtnCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/28.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidClickSaveBtn)();
typedef void (^DidClickDeleteBtn)();


@interface editAddressBtnCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic, copy) DidClickDeleteBtn didclickDeleteBtn;
@property (nonatomic, copy) DidClickSaveBtn didClickSaveBtn;

-(void)setupCell;

@end
