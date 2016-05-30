//
//  IFPhotoTableViewCell.m
//  iFruit
//
//  Created by administrator on 15/8/13.
//  Copyright (c) 2015年 gem. All rights reserved.
//

#import "IFPhotoTableViewCell.h"


@interface IFPhotoTableViewCell() <UITextViewDelegate>



@end

@implementation IFPhotoTableViewCell
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

- (void)awakeFromNib {
    // Initialization code
    self.placeholderLabel.layer.masksToBounds = YES;
    self.placeholderLabel.layer.borderWidth = 1;
    self.placeholderLabel.layer.borderColor = [RGB_COLOR(200, 200, 200)CGColor];
    self.commentView.delegate = self;
    self.commentView.backgroundColor = [UIColor clearColor];
    self.commentView.tag = 501;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.placeholderLabel.text = @"";
}

-(void)textViewDidEndEditing:(UITextView *)textView{

    [textView resignFirstResponder];
}



- (IBAction)enterAlbumAndCameraClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(enterAlbumAndCamera)]) {
        [self.commentView resignFirstResponder];
        if (self.commentView.text.length > 0) {
            
            
        }
        else{
            self.placeholderLabel.text = @"亲,写点什么吧，您的意见对其他团友有很大帮助！";
        }
        
        [self.delegate enterAlbumAndCamera];
        
    }
}



@end
