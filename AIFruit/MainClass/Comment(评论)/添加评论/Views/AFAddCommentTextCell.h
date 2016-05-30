//
//  AFAddCommentTextCell.h
//  AIFruit
//
//  Created by Kosne on 16/5/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidCommentText)(NSString *);

@interface AFAddCommentTextCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *contText;

@property (weak, nonatomic) IBOutlet UITextField *commentText;


@property (nonatomic, copy) DidCommentText didCommentText;



@end
