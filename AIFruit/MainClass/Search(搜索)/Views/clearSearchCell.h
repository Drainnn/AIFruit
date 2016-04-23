//
//  clearSearchCell.h
//  AIFruit
//
//  Created by Kosne on 16/4/19.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DidClearSearchRecord)();


@interface clearSearchCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

@property (copy, nonatomic) DidClearSearchRecord didclearSearchRecord;

-(void)setupCell;

@end
