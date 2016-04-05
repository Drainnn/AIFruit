//
//  SearchBarView.m
//  AIFruit
//
//  Created by Kosne on 16/3/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "SearchBarView.h"

@implementation SearchBarView

+(SearchBarView *)initSearchBarView{
    SearchBarView *view = (SearchBarView *)[[UIView alloc]init];
    
    view.frame = CGRectMake(0, 20, 300, 25);
    view.backgroundColor = UIColorWithRGBA(106, 203, 93, 0.2);
    view.layer.cornerRadius = 12;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    label.text = @"kobe";
    
    [view addSubview:label];
    
    [view addBackViewWithParentView:view];
    
    return view;
}


#pragma mark - 搜索背景图
-(void)addBackViewWithParentView:(UIView *)view{
    if ([view isKindOfClass:[SearchBarView class]]) {
        view = (SearchBarView *)view;
    }
    
    UIImageView *ImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-search"]];
    ImgView.frame = CGRectMake(0, 0, 20, 20);
    
    UILabel *label;
    label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 34, 70, 30);
    label.text = @"请输入商品名称";
    label.backgroundColor = [UIColor greenColor];
    
    [view addSubview:ImgView];
    [view addSubview:label];
    
}


-(void)handleSingleTapFrom{
    NSLog(@"tap");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
