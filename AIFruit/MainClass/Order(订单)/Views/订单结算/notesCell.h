//
//  notesCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/24.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface notesCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UITextField *notesField;

-(void)setupCell;

@end
