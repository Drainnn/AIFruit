//
//  detailfourCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "detailfourCell.h"

@implementation detailfourCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithFruit:(detailFruit *)fruit{
    self.commentNumLabel.text = [NSString stringWithFormat:@"用户评价(%d)",fruit.commentNum];
    self.greatCommentLabel.text = [NSString stringWithFormat:@"%d好评",fruit.greatComment];
}

@end
