//
//  AFAddCommentController.m
//  AIFruit
//
//  Created by Kosne on 16/5/27.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "AFAddCommentController.h"
#import "AFNetworking.h"
#import "AFCommentFruitInfoCell.h"
#import "AFAddCommentTextCell.h"
#import "IFGradeTableViewCell.h"
#import "AFCommentGradeCell.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"


@interface AFAddCommentController ()<UITableViewDataSource,UITableViewDelegate,FlowerRatingViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>{
    NSString *commentText;
     int commentGrade;
    NSString *paraStr;
    int flag;
}


@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) UIButton *OKBtn;
@property (nonatomic, strong) NSMutableArray *fruitIDArr;
@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation AFAddCommentController

-(NSMutableArray *)fruitIDArr{
    if (!_fruitIDArr) {
        _fruitIDArr = [NSMutableArray array];
    }
    return _fruitIDArr;
}

-(UIAlertView *)alertView{
    if (!_alertView) {
        _alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写评论内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    }
    return _alertView;
}

-(UIButton *)OKBtn{
    if (!_OKBtn) {
        CGRect rect = self.view.bounds;
        rect.size.height -= 100;
        CGFloat centerX = self.view.center.x;
        _OKBtn = [[UIButton alloc]initWithFrame:CGRectMake(centerX-75, rect.size.height + 20, 150, 35)];
        [_OKBtn setTitle:@"确定" forState:UIControlStateNormal];
        _OKBtn.layer.cornerRadius = 5;
        _OKBtn.layer.borderColor = themeColor.CGColor;
        _OKBtn.layer.borderWidth = 0.5;
        [_OKBtn setTitleColor:themeColor forState:UIControlStateNormal];
        [_OKBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _OKBtn;
}

-(UITableView *)dataTableView{
    if (!_dataTableView) {
        CGRect rect = self.view.bounds;
        rect.size.height -= 100;
        _dataTableView = [[UITableView alloc]initWithFrame:rect];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.tableFooterView = [UIView new];
    }
    return _dataTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"添加评论";
    
    [self.view addSubview:self.dataTableView];
    [self.view addSubview:self.OKBtn];
    commentText = @"";
    flag = 1;
    commentGrade = 5;
    for (NSDictionary *dict in self.dataArray) {
        int fruitId = [dict[@"fruitId"] intValue];
        NSDictionary *dic = @{
                               @"fruitId":@(fruitId)
                               };
        [self.fruitIDArr addObject:dic];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.fruitIDArr options:NSJSONWritingPrettyPrinted error:nil];
    paraStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataArray.count;
    }else{
        return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else if(indexPath.section == 1){
        return 70;
    }else{
        return 30;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifier = @"AFCommentFruitInfoCell";
        AFCommentFruitInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
        [cell setupCell:dic];
        return cell;
    }else if(indexPath.section == 1){
        static NSString *identifier = @"AFCommentGradeCell";
        AFCommentGradeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        cell.ratingView.delegate = self;
        return cell;
//    IFGradeTableViewCell *gradeCell = [tableView dequeueReusableCellWithIdentifier:@"gradeCell"];
//    gradeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    return  gradeCell;
    }
    else{
        static NSString *identifier = @"AFAddCommentTextCell";
        AFAddCommentTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        [cell.commentText addTarget:self action:@selector(textViewValueEditing:) forControlEvents:UIControlEventEditingChanged];
        cell.commentText.delegate = self;
        cell.didCommentText = ^(NSString *text){
            commentText = text;
        };
        return cell;
    }
    
}

-(void)flowerRatingView:(IFRatingView *)view grade:(float)grade{
    commentGrade = grade * 5 + 1;
}

-(void)BtnAction:(UIButton *)btn{
    if ([@"" isEqualToString:commentText]) {
    
        [self.alertView show];
    }else{
        [self sendRequest];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

-(void)sendRequest{
    NSDictionary *para = @{
                           @"orderNO":self.orderNO,
                           @"userId":@(APPDELEGATE.userinfo.id),
                           @"fruitIds":paraStr,
                           @"score":@(commentGrade),
                           @"content":commentText,
                           @"comImgUrl":@"nil"
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:AddNewCommentUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = dict[@"code"];
        if ([@"200" isEqualToString:code]) {
            [self setWarnInfor:@"已评论"];
            [self performSelector:@selector(popView) withObject:nil afterDelay:1];
        }else{
            NSLog(@"返回错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送接口请求失败");
        if (flag < 5) {
            flag++;
            [self sendRequest];
        }
    }];
}

-(void)popView{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)textViewValueEditing:(UITextView *)textView{
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.dataTableView.frame = CGRectMake(0, -90, self_screen_width, self_screen_height);
}

-(void)setWarnInfor:(NSString *)info{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = info;
    hud.color = [UIColor grayColor];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    AFAddCommentTextCell *cell = [self.dataTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
//    [cell.commentText resignFirstResponder];
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
     // 空白处收起
}

@end
