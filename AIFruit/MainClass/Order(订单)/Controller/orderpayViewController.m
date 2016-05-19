//
//  orderpayViewController.m
//  AIFruit
//
//  Created by Kosne on 16/4/28.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "orderpayViewController.h"
#import "orderpayBodyView.h"
#import "AliOrder.h"

@implementation Product


@end



@interface orderpayViewController ()

@property (nonatomic, strong) UIView *topTitleView;//顶部标题提示视图

@property (nonatomic, strong) orderpayBodyView *bodyView;//订单信息视图

@property (nonatomic, strong) UIButton *toPayBtn;//去支付按钮

@end


@implementation orderpayViewController

-(orderpayBodyView *)bodyView{
    if (!_bodyView) {
        _bodyView = [[orderpayBodyView alloc]initWithFrame:CGRectMake(10, _topTitleView.bounds.size.height+navigation_height, self_screen_width-20, 200)];
        
    }
    return _bodyView;
}

-(UIButton *)toPayBtn{
    if (!_toPayBtn) {
        _toPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(87, 355, 147, 36)];
        [_toPayBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_toPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_toPayBtn setBackgroundColor:themeColor];
        _toPayBtn.layer.cornerRadius = 5;
        [_toPayBtn.titleLabel setFont:UIFontWithSize(14)];
//        [_toPayBtn addTarget:self action:@selector(toAlipay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toPayBtn;
}

//-(void)toAlipay{
//        /*
//         *点击获取prodcut实例并初始化订单信息
//         */
//        Product *product = [[Product alloc]init];
//        
//        /*
//         *商户的唯一的parnter和seller。
//         *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
//         */
//        
//        /*============================================================================*/
//        /*=======================需要填写商户app申请的===================================*/
//        /*============================================================================*/
//    NSString *partner = @"2088802366482234";
//    NSString *seller = @"804063213@qq.com";
//    NSString *privateKey =@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANE71e0Yl8VGfJX4glWRhMay6vdfU/fQ4+1Bn4tEdSn98hG4tIrW1FEIQJjyZpZSSxX4nyG/aZbxwDH8FfEYvsPWd2nMJ0HfI3xBujeJsdCj/Dvje2KTjg07Jl7W+ENFz3QEWvGQU557z/kJU1CAse6eD0y5UImEErgVVSJ9h87pAgMBAAECgYBRvyP8p0AcxkZEvbwGPH14uEyO64K97rIubxYrbkqsZlgeTmDTYc2//w5l80bbcjl90w4xPDy/yaICpW/ZK4bT/QdXIuH33pxOx1CteXfc0j26fLfFUWVxLuPPSa9U1bbqCsIaYLEQ9Ti2/4KphU0fw5SDbHgY7ujF8eij/BxxJQJBAP+sGQfU0jZv0DQqReJIGcfcbMJNiTpgQ2ODIA599BLEoNcOkbMGYmXlQEGZuF3vJjq1JZfWIYw3tY9nefrTI5cCQQDRgH+bAlB1lH6JH6NT6ndceUOsIR8DWRgdHTrJ+KZFnHV6gHaDGEneux5wJT4xl246iZBFOdg/BkhppeSw+PF/AkEA2Sbjr5ob3S6EyPmql3Gjq/PU0Aco6dL/CZNCc+yYlCQ7c80lBMgEZQUc2Vrlk6rebniS8G5n2f8rDxzVJquUCwJAeqq3jKZ1P/Nbh6SLuGXPz8h9FDsscoRnNxzXQE0j5hxvOPQg8C93iT+c2eMkoFrfQs0rOS1ebcCbA6kL14dbtwJAeu2niLVy9kJQjbbBOvgxke1V+0cxPmRnvKDoYvb4briZb0RyGnnvMLFYgv3OOJLqtbnWvnyaOsRZ7MRX7TIO/w==";
//        /*============================================================================*/
//        /*============================================================================*/
//        /*============================================================================*/
//        
//        //partner和seller获取失败,提示
//        if ([partner length] == 0 ||
//            [seller length] == 0 ||
//            [privateKey length] == 0)
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                            message:@"缺少partner或者seller或者私钥。"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil];
//            [alert show];
//            return;
//        }
//        
//        /*
//         *生成订单信息及签名
//         */
//        //将商品信息赋予AlixPayOrder的成员变量
//        AliOrder *order = [[AliOrder alloc] init];
//        order.partner = partner;
//        order.sellerID = seller;
//        order.outTradeNO = @"234234324234"; //订单ID（由商家自行制定）
//        order.subject = product.subject; //商品标题
//        order.body = product.body; //商品描述
//        order.totalFee = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
//        order.notifyURL =  @"http://www.xxx.com"; //回调URL
//        
//        order.service = @"mobile.securitypay.pay";
//        order.paymentType = @"1";
//        order.inputCharset = @"utf-8";
//        order.itBPay = @"30m";
//        order.showURL = @"m.alipay.com";
//        
//        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//        NSString *appScheme = @"alisdkdemo";
//        
//        //将商品信息拼接成字符串
//        NSString *orderSpec = [order description];
//        NSLog(@"orderSpec = %@",orderSpec);
//        
//        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//        id<DataSigner> signer = CreateRSADataSigner(privateKey);
//        NSString *signedString = [signer signString:orderSpec];
//    
//        //将签名成功字符串格式化为订单字符串,请严格按照该格式
//        NSString *orderString = nil;
////        if (signedString != nil) {
//            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                           orderSpec, signedString, @"RSA"];
//            
//            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                NSLog(@"reslut = %@",resultDic);
//            }];
////        }
//    
//}

-(UIView *)topTitleView{
    if (!_topTitleView) {
        _topTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, navigation_height, self_screen_width, 70)];
//        [_topTitleView setBackgroundColor:[UIColor redColor]];
        CGFloat getY = _topTitleView.bounds.size.height / 2;
               UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, getY, 32, 32)];
        [imageView setImage:[UIImage imageNamed:@"checkbox-selected"]];
        CGPoint imgCenter = CGPointMake(30, getY);
        imageView.center = imgCenter;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 280, 30)];
        CGPoint labelCenter = CGPointMake(self_screen_width/2+30, getY);
        label.center = labelCenter;
        label.text = @"订单提交成功，请尽快支付!";
        label.font = UIFontWithSize(20);
        label.textColor = themeColor;
        
        
        [_topTitleView addSubview:imageView];
        [_topTitleView addSubview:label];
    }
    return _topTitleView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,17, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backBtn;
    
    
    
    self.title = @"订单支付";
    
    [self.view setBackgroundColor:UIColorWithRGB(242, 242, 242)];
    [self.view addSubview:self.topTitleView];
    [self.view addSubview:self.bodyView];
    [self.view addSubview:self.toPayBtn];
}

-(void)popView{
    //发送通知
    NSNotification *not = [NSNotification notificationWithName:orderpopToshopcar object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:not];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
