//
//  HotRecommendViewCell.h
//  AIFruit
//
//  Created by Kosne on 16/3/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidToSearchList)(NSString *keyWord);

@interface HotRecommendViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *oneBtn;

@property (weak, nonatomic) IBOutlet UIButton *twoBtn;

@property (weak, nonatomic) IBOutlet UIButton *threeBtn;


@property (weak, nonatomic) IBOutlet UIButton *fourBtn;


@property (weak, nonatomic) IBOutlet UIView *fiveBtn;


@property (weak, nonatomic) IBOutlet UIView *sixBtn;


@property (weak, nonatomic) IBOutlet UIView *siveBtn;

@property (weak, nonatomic) IBOutlet UIView *eightBtn;

@property (weak, nonatomic) IBOutlet UIView *nineBtn;


@property (nonatomic, strong) NSMutableArray *BtnArr;

@property (nonatomic, copy) DidToSearchList didtosearchlist;

-(void)setupCell;


@end
