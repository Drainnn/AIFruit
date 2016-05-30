//
//  userHeadInfoCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "userHeadInfoCell.h"
#import "AppDelegate.h"

@implementation userHeadInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 14, 60, 60)];
    }
    return _headImgView;
}

-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 79, 140, 21)];
    }
    return _phoneLabel;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(135, 102, 83, 21)];
    }
    return _titleLabel;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(120, 28, 80, 80)];
    }
    return _loginBtn;
}

-(void)setupInfoCell{
    if (APPDELEGATE.isLogin) {
        
        self.headImgView.layer.cornerRadius = 30;
        self.headImgView.layer.borderColor = themeColor.CGColor;
        self.headImgView.layer.borderWidth = 1.0f;
        [self.headImgView setImage:[UIImage imageNamed:@"icon.png"]];

        self.phoneLabel.text = APPDELEGATE.userinfo.mobileNo;
        [self.phoneLabel setFont:UIFontWithSize(12)];
        
        self.titleLabel.text = @"钻石用户";
        [self.titleLabel setFont:UIFontWithSize(12)];
        [self.phoneLabel setTextColor:themeColor];
        [self.titleLabel setTextColor:[UIColor grayColor]];
        
        [self setBackgroundColor:UIColorWithRGB(236, 247, 243)];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.headImgView];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.titleLabel];
        [self.loginBtn removeFromSuperview];
    }else{
    
        [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"btn-login"] forState:UIControlStateNormal];
        [self.loginBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self.loginBtn setTitle:@"" forState:UIControlStateNormal];
        [self setBackgroundColor:UIColorWithRGB(220, 242, 219)];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.loginBtn];
        [self.headImgView removeFromSuperview];
        [self.phoneLabel removeFromSuperview];
        [self.titleLabel removeFromSuperview];
    }
}


-(void)setupBtnCell{
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(120, 28, 80, 80)];
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"btn-login"] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"" forState:UIControlStateNormal];
    [self setBackgroundColor:UIColorWithRGB(220, 242, 219)];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.loginBtn];
}

-(void)action:(UIButton *)btn{
    _tologinView();
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, UIColorWithRGBA(237, 237, 237, 1.0f).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}

@end
