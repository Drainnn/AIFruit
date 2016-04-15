//
//  detailImgScrollView.m
//  AIFruit
//
//  Created by Kosne on 16/4/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "detailImgScrollView.h"
#import "UIImageView+WebCache.h"

#define This_Width self.frame.size.width
#define This_Height self.frame.size.height

@interface detailImgScrollView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation detailImgScrollView

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    }
    return _scrollView;
}

-(void)setupScrollViewWithArray:(NSArray *)imgArray{
    
    NSInteger length = imgArray.count;
    self.scrollView.contentSize = CGSizeMake(length*This_Width, 0);
    for (int i = 0; i < length; i++) {
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*This_Width, 0, This_Width, This_Height)];
//        NSURL *url = [NSURL URLWithString:imgArray[i]];
//        [imgView sd_setImageWithURL:url placeholderImage:nil];
        imgView.image = [UIImage imageNamed:imgArray[i]];
        [self.scrollView addSubview:imgView];
    }
     [self addSubview:self.scrollView];
}

-(instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)imgArray{
    if (self = [super initWithFrame:frame]) {
        
        [self setupScrollViewWithArray:imgArray];
    }
    return self;
}




@end
