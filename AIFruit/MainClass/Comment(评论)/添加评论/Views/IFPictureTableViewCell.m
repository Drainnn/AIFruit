//
//  IFPictureTableViewCell.m
//  iFruit
//
//  Created by administrator on 15/8/14.
//  Copyright (c) 2015年 gem. All rights reserved.
//

#import "IFPictureTableViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "JKAssets.h"

@implementation IFPictureTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showImage:(NSMutableArray *)assetArray{
    
    
    int space = 10;
    int margin = 20;
    int imageWith = (self_screen_width - margin*2 - space*2) / 3;
    int imageHeight = imageWith;
    int i , j;
    for (i = 0; i < 2; i++) {
        for (j = 0; j < 3; j++) {
            if (3 * i + j >= assetArray.count) {
                break;
            }
        JKAssets *asset = [assetArray objectAtIndex:3 * i + j];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(margin + imageWith * j + space * j, 10 + imageHeight * i + 10 * i, imageHeight, imageWith)];
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            imgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteImage:)];
            [imgView addGestureRecognizer:tapGesture];
            tapGesture.numberOfTapsRequired = 1; //点击次数
            tapGesture.numberOfTouchesRequired = 1;
            UIImageView *view = (UIImageView *)[tapGesture view];
            view.tag = (NSInteger)i * 3 + j +100;
            imgView.layer.masksToBounds = YES;
            imgView.layer.cornerRadius = 4;
            ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
            [lib assetForURL:asset.assetPropertyURL resultBlock:^(ALAsset *asset) {
                if (asset) {
                    imgView.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                }
            } failureBlock:^(NSError *error) {
                
            }];
        [self.contentView addSubview:imgView];
        
        }
  }
}


-(void)deleteImage:(UITapGestureRecognizer *)recognizer{
    NSInteger index = recognizer.view.tag;
    if ([self.delegate respondsToSelector:@selector(showZLPhotoPickerBrowserViewController:andImage:)]) {
        [self.delegate showZLPhotoPickerBrowserViewController:index andImage:recognizer.view];
    }
}

@end
