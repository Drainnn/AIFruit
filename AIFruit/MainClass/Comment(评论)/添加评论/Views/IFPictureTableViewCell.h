//
//  IFPictureTableViewCell.h
//  iFruit
//
//  Created by administrator on 15/8/14.
//  Copyright (c) 2015年 gem. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IFPictureTableViewCellDelegate <NSObject>

-(void)showZLPhotoPickerBrowserViewController:(NSInteger)index andImage:(UIView *)view;

@end
@interface IFPictureTableViewCell : UITableViewCell
@property (nonatomic,weak)id<IFPictureTableViewCellDelegate>delegate;


-(void)showImage:(NSMutableArray *)assetArray;

@end
