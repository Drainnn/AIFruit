//
//  chooseReceiverCell.h
//  AIFruit
//
//  Created by Kosne on 16/5/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"

typedef void (^DidBtnClicked)(Address *);

@interface chooseReceiverCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *receiverLabel;

@property (weak, nonatomic) IBOutlet UILabel *mobileNoLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailADLabel;

@property (weak, nonatomic) IBOutlet UIButton *toDetailBtn;

@property (weak, nonatomic) IBOutlet UILabel *flagLabel;

@property (weak, nonatomic) IBOutlet UIImageView *chooseFlagImgae;


@property (nonatomic, copy) DidBtnClicked didBtnClicked;



-(void)setupCellWithAddress:(Address *)address;

@end
