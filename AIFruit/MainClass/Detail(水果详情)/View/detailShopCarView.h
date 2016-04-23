//
//  detailShopCarView.h
//  AIFruit
//
//  Created by Kosne on 16/4/22.
//  Copyright © 2016年 Kosne. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol detailShopCarViewDelegate <NSObject>

-(void)didClickShopCar;

@end

@interface detailShopCarView : UIView

-(instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, weak) id<detailShopCarViewDelegate> delegate;



@end
