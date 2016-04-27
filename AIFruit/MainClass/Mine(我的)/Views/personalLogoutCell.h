//
//  personalLogoutCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidLogoutBtn)();

@interface personalLogoutCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@property (nonatomic, copy) DidLogoutBtn didlogoutBtn;

-(void)setupCell;

@end
