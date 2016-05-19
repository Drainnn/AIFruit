//
//  editAddressInfoCell.m
//  AIFruit
//
//  Created by Kosne on 16/4/28.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "editAddressInfoCell.h"

@interface editAddressInfoCell ()<UITextFieldDelegate>

@end

@implementation editAddressInfoCell

- (void)awakeFromNib {
    // Initialization code
    [self.contField addTarget:self action:@selector(TextFieldChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithAddress:(Address *)address andIndex:(NSInteger)index{
    self.contField.tag = index;
    if (index == 0) {
        [self setupTitle:@"收货人" andCont:address.receiveUser];
    }else if (index == 1){
        [self setupTitle:@"联系方式" andCont:address.contact];
    }else if (index == 2){
        [self setupTitle:@"区域选择" andCont:address.addressArea];
    }else if (index == 3){
        [self setupTitle:@"详细地址" andCont:address.detailAD];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setupTitle:(NSString *)title andCont:(NSString *)cont{
    self.titleLabel.text = title;
    self.contField.text = cont;
}

-(void)TextFieldChange:(UITextField *)sender{
    _didChangeFieldText(sender.text,sender.tag);
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 2));
}

@end
