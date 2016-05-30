//
//  IFPhotoTableViewCell.h
//  iFruit
//
//  Created by administrator on 15/8/13.
//  Copyright (c) 2015年 gem. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IFPhotoTableViewCellDelegate <NSObject>

-(void)enterAlbumAndCamera;

@end

@interface IFPhotoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *commentView;

@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@property (weak,nonatomic)id<IFPhotoTableViewCellDelegate> delegate;

@end
