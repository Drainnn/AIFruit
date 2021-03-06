//
//  detailViewController.m
//  AIFruit
//
//  Created by Kosne on 16/4/12.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "detailViewController.h"
#import "detailImgScrollView.h"
#import "detailoneCell.h"
#import "detailtwoCell.h"
#import "detailthreeCell.h"
#import "detailfourCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "detailFruit.h"
#import "fruitCommentController.h"
#import "detailShopCarView.h"
#import "ThrowLineTool.h"
#import "AppDelegate.h"
#import "NSMutableDictionary+shopCarDictionary.h"
#define bg_Height 260

@interface detailViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,detailShopCarViewDelegate,ThrowLineToolDelegate>{
    
    int fruitnum;
}
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) UIScrollView *imgScrollView;
@property (nonatomic, copy) NSArray *imgArr;
@property (nonatomic, strong) detailFruit *fruit;
@property (nonatomic, strong) detailShopCarView *detailShopCar;
@property (nonatomic, strong) ThrowLineTool *throwTool;
@property (nonatomic, strong) UIImageView *redView;

@end

@implementation detailViewController{
    __weak UIPageControl *pageControl;
    int currentIndex;
}

-(detailFruit *)fruit{
    if (!_fruit) {
        _fruit = [[detailFruit alloc]init];
    }
    return _fruit;
}


-(NSArray *)imgArr{
    if (!_imgArr) {
        _imgArr = @[@"JAVA.jpg",@"JAVA_1.jpg",@"JAVA_2.jpg"];
    }
    return _imgArr;
}

-(UIScrollView *)imgScrollView{
    if (!_imgScrollView) {
        _imgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self_screen_width, bg_Height)];
        _imgScrollView.showsHorizontalScrollIndicator = NO;
        _imgScrollView.showsVerticalScrollIndicator = NO;
        _imgScrollView.delegate = self;
        _imgScrollView.pagingEnabled = YES;
    }
    return _imgScrollView;
}

-(UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -bg_Height, self_screen_width, bg_Height)];
        [_bgView setImage:[UIImage imageNamed:@"test.jpg"]];
        _bgView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _bgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"title";
        _titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel sizeToFit];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.alpha = 0;
    }
    return _titleLabel;
}

-(UITableView *)dataTableView{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        _dataTableView.tableFooterView = [[UIView alloc]init];
        _dataTableView.contentInset = UIEdgeInsetsMake(bg_Height, 0, 0, 0);
    }
    return _dataTableView;
}

-(detailShopCarView *)detailShopCar{
    if (!_detailShopCar) {

        _detailShopCar = [[detailShopCarView alloc]initWithFrame:CGRectMake(self_screen_width-70, self_screen_height-120, 50, 50)];
        _detailShopCar.delegate = self;
    }
    return _detailShopCar;
}

-(ThrowLineTool*)throwTool{
    if (!_throwTool) {
        _throwTool = [ThrowLineTool sharedTool];
    }
    return _throwTool;
}

-(UIImageView *)redView{
    if (!_redView) {
        _redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _redView.image = [UIImage imageNamed:@"adddetail"];
        _redView.layer.cornerRadius = 10;
    }
    return _redView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    fruitnum = 1;
    [self setupTableView];
    [self setupPageControl];
    [self setupShopCarView];
    [self sendRequest];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setupNav];
}


#pragma mark - 发送接口请求
-(void)sendRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *para = @{
                          @"id":@(self.id)
                          };
    [manager GET:DetailFruitById parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *code = [dict valueForKey:@"code"];
        if ([@"200" isEqualToString:code]) {
            NSDictionary *dic = [dict valueForKey:@"data"];
            detailFruit *fruit = [detailFruit objectWithKeyValues:dic];
            self.fruit = fruit;
            
            [self.dataTableView reloadData];
            
        }else{
            NSLog(@"请求结果错误");
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
}

#pragma mark - 设置导航栏透明
-(void)setupNav{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

#pragma mark - 设置scrollView
-(void)setupScrollViewWithArray:(NSArray *)imgArray{
    NSInteger length = imgArray.count;
    self.imgScrollView.contentSize = CGSizeMake(length*self_screen_width, 0);
    for (int i = 0; i < length; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*self_screen_width, 0, self_screen_width, bg_Height)];
        imageView.image = [UIImage imageNamed:imgArray[i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = 24 + i;
        [self.imgScrollView addSubview:imageView];
    }
    [self.dataTableView addSubview:self.imgScrollView];
}

-(void)setupPageControl{
    UIPageControl *pagectl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, -60, self_screen_width, 37)];
    pagectl.pageIndicatorTintColor = [UIColor grayColor];
    pagectl.currentPageIndicatorTintColor = themeColor;
    pagectl.numberOfPages = self.imgArr.count;
    pagectl.currentPage = 0;
    [self.dataTableView addSubview:pagectl];
    [self.dataTableView bringSubviewToFront:pagectl];
    pageControl = pagectl;
}

#pragma mark - 设置tableView
-(void)setupTableView{
    [self.view addSubview:self.dataTableView];
    [self setupScrollViewWithArray:self.imgArr];
}

-(void)setupShopCarView{
    [self.view addSubview:self.detailShopCar];
    [self.view bringSubviewToFront:self.detailShopCar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 75;
    }else if (indexPath.row == 1){
        return 50;
    }else if (indexPath.row == 2){
        return 65;
    }else{
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *identifier = @"detailoneCell";
        detailoneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"detailoneCell" owner:nil options:nil] firstObject];
        }
        __weak detailViewController *weakSelf = self;
        cell.changefruitnum = ^(int num){
            [weakSelf changefruitName:num];
        };
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupCellWithFruit:self.fruit];
        return cell;
    }else if (indexPath.row == 1){
        static NSString *identifier = @"detailtwoCell";
        detailtwoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"detailtwoCell" owner:nil options:nil] firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupCellWithFruit:self.fruit];
        return cell;
    }else if (indexPath.row == 2){
        static NSString *identifier = @"detailthreeCell";
        detailthreeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"detailthreeCell" owner:nil options:nil] firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupCellWithFruit:self.fruit];
        return cell;
    }else{
        static NSString *identifier = @"detailfourCell";
        detailfourCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"detailfourCell" owner:nil options:nil] firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupCellWithFruit:self.fruit];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        int fruitId = self.fruit.id;
        int commentNum = self.fruit.commentNum;
        int totalScore = self.fruit.totalScore;
        double greatComemnt = (1.0 * self.fruit.greatComment / self.fruit.commentNum);
        fruitCommentController *fcVC = [[UIStoryboard storyboardWithName:@"fruitCommentStoryboard" bundle:nil]instantiateInitialViewController];
        fcVC.fruitId = fruitId;
        fcVC.commentNum = commentNum;
        fcVC.totalScore = totalScore;
        fcVC.greatComment = greatComemnt;
        [self.navigationController pushViewController:fcVC animated:YES];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat offsetH = bg_Height + offsetY;
        
        if (offsetH < 0) {
            CGRect frame     = self.imgScrollView.frame;
            frame.size.height = bg_Height - offsetH;
            frame.origin.y = -bg_Height + offsetH;
            self.imgScrollView.frame = frame;
            
            for (UIView *view in [self.imgScrollView subviews]) {
                if ([view isKindOfClass:[UIImageView class]]) {
                    if (view.tag == currentIndex + 24) {
                        CGRect imgFrame = view.frame;
                        imgFrame.size.height = bg_Height - offsetH;
                        view.frame = imgFrame;
                    }
                    
                }
            }
        }
        CGFloat alpha = offsetH / bg_Height;
        //    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
        self.titleLabel.alpha = alpha;
    }else{
        CGFloat offsetX = scrollView.contentOffset.x;
        int page = offsetX / self_screen_width;
        pageControl.currentPage = page;
        currentIndex = page;
    }
}

#pragma mark - cell改变商品数量按钮相应的回调
-(void)changefruitName:(int)num{
    fruitnum = num;
}


#pragma mark - 点击添加购物车视图按钮的代理事件
-(void)didClickShopCar{
    CGRect parentRectB = CGRectMake(1.0*320/5*3, self_screen_height-self_tabbar_height, 1.0*320/5, self_tabbar_height);
    [self.view addSubview:self.redView];
    
    
    //当前数组里是否存在的标志
    int isExist = 0;
    for (NSMutableDictionary *dict in APPDELEGATE.shopCarArray) {
        if ([[dict valueForKey:shopCar_Fruit_Id_Key] isEqualToString:[NSString stringWithFormat:@"%d",self.id]]) {
            int num = [[dict valueForKey:shopCar_Fruit_Num_Key]intValue];
            num += fruitnum;
            [dict setObject:[NSString stringWithFormat:@"%d",num] forKey:shopCar_Fruit_Num_Key];
            [APPDELEGATE.shopCarArray writeToFile:APPDELEGATE.shopCarFilePath atomically:YES];
            //修改总价
            APPDELEGATE.mainTabController.totalPrice += ([dict[shopCar_Fruit_Price_Key]intValue]*fruitnum);
            isExist = 1;
            break;
        }
    }
    if (!isExist) {
        NSMutableDictionary *dict = [NSMutableDictionary setDictByObj:self.fruit WithNum:fruitnum];
        [APPDELEGATE.shopCarArray addObject:dict];
        [APPDELEGATE.shopCarArray writeToFile:APPDELEGATE.shopCarFilePath atomically:YES];
        //修改总价
        APPDELEGATE.mainTabController.totalPrice += ([dict[shopCar_Fruit_Price_Key]intValue]*fruitnum);
    }
    //更改总数量
    APPDELEGATE.mainTabController.totalNum += fruitnum;
    
    //发送通知
    NSNotification *notice = [NSNotification notificationWithName:numChangeFromDetail object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    [self.throwTool throwObject:self.redView from:self.detailShopCar.frame.origin to:parentRectB.origin type:2];
    self.throwTool.delegate = self;
}

-(void)animationDidFinish{
    APPDELEGATE.mainTabController.badgeView.badgeValue = APPDELEGATE.mainTabController.totalNum;
    [self.redView removeFromSuperview];
    CGRect rect = self.redView.frame;
    rect.size.width += 10;
    rect.size.height += 10;
    self.redView.frame = rect;
}


#pragma mark - 返回一张纯色图片
/** 返回一张纯色图片 */
- (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


@end
