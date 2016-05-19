//
//  receiveUserCell.h
//  AIFruit
//
//  Created by Kosne on 16/5/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidChangeFieldText)(NSString *cont);

@interface receiveUserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *contField;

@property (nonatomic, copy) DidChangeFieldText didChangeFieldText;

-(void)setupCell;


@end
