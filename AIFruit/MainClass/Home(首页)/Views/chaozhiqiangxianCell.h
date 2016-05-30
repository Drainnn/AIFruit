//
//  chaozhiqiangxianCell.h
//  AIFruit
//
//  Created by Kosne on 16/5/20.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chaozhiqiangxianCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *leftBtn;


@property (weak, nonatomic) IBOutlet UIButton *centerBtn;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;



-(void)setupCell;

@end
