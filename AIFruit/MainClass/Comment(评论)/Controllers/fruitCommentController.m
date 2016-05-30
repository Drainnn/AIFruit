//
//  fruitCommentController.m
//  AIFruit
//
//  Created by Kosne on 16/4/17.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "fruitCommentController.h"
#import "commentCell.h"
#import "Comment.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "commentTopView.h"

@interface fruitCommentController ()<UITableViewDataSource,UITableViewDelegate>{
    NSString *titleStr;
}

@property (nonatomic, strong) NSMutableArray *commentArr;
@property (nonatomic, strong) commentTopView *topView;
@property (nonatomic, strong) MBProgressHUD *waitHud;


@end

@implementation fruitCommentController

-(MBProgressHUD *)waitHud{
    if (!_waitHud) {
        _waitHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    }
    return _waitHud;
}

-(NSMutableArray *)commentArr{
    if (!_commentArr) {
        _commentArr = [NSMutableArray array];
    }
    return _commentArr;
}

-(UITableView *)dataTableView{
    if (!_dataTableView) {
        CGRect rect = self.view.bounds;
        rect.origin.y = 60;
        rect.size.height -= 60;
        
        _dataTableView = [[UITableView alloc]initWithFrame:rect];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.tableFooterView = [UIView new];
        _dataTableView.rowHeight = 82;
        _dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dataTableView.showsVerticalScrollIndicator = NO;
    }
    return _dataTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sendRequest];
    [self initTitleView];
    [self.view addSubview:self.dataTableView];
    [self initTopView];
    [self setWarnInfor:@"网络连接异常"];
    [self showhud];
}

-(void)showhud{
    self.waitHud.mode = MBProgressHUDModeIndeterminate;
    self.waitHud.color = [UIColor grayColor];
    self.waitHud.margin = 10.f;
    self.waitHud.removeFromSuperViewOnHide = YES;
}

-(void)sendRequest{
    NSDictionary *para = @{
                           @"id":@(self.fruitId)
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:FruitCommentById parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = [dict valueForKey:@"code"];
        if ([@"200" isEqualToString:code]) {
            
            NSArray *arr = [dict valueForKey:@"data"];
            for (NSDictionary *dic in arr) {
                Comment *comment = [Comment objectWithKeyValues:dic];
                [self.commentArr addObject:comment];
            }
            
            [self.waitHud hide:YES];
            
            [self.dataTableView reloadData];
            
        }else{
            NSLog(@"请求结果错误");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"接口请求失败");
    }];
}

-(void)setWarnInfor:(NSString *)info{
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = info;
//    hud.margin = 10.f;
//    hud.color = [UIColor grayColor];
//    hud.removeFromSuperViewOnHide = YES;
//    [hud hide:YES afterDelay:10];
    
}

#pragma mark - 初始化tableView
-(void)initTableView{
    
//    _dataTableView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
//    [self.view addSubview:_dataTableView];
}

#pragma mark - 初始化topView
-(void)initTopView{
    double score = (1.0 * _totalScore / _commentNum );
    double greatComemnt = _greatComment;
    _topView = [[commentTopView alloc]initWithFrame:CGRectMake(-0.5, navigation_height, self_screen_width+1, 60) andScore:score andGreatComment:greatComemnt];

    [self.view addSubview:_topView];
}

-(void)initTitleView{
    titleStr = [NSString stringWithFormat:@"评价(%d)",self.commentNum];
    self.navigationItem.title = titleStr;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"commentCell";
    commentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"commentCell" owner:nil options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Comment *comment = [self.commentArr objectAtIndex:indexPath.row];
    [cell setupCellWithComment:comment];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
