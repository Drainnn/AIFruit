//
//  shoppingCarController.m
//  AIFruit
//
//  Created by Kosne on 16/4/18.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "shoppingCarController.h"
#import "BadgeView.h"
#import "shopCarInfoCell.h"
#import "AppDelegate.h"
#import "shopCarBottomView.h"

@interface shoppingCarController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) shopCarBottomView *bottomView;

@end

@implementation shoppingCarController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIFont *font = UIFontWithSize(16);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : themeColor,NSFontAttributeName : font}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    
    [self initTableView];
    [self initBottomView];
    
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didNotice:) name:numChangeFromFruitList object:nil];
    [center addObserver:self selector:@selector(didNotice:) name:numChangeFromDetail object:nil];
}

#pragma mark - 接收到其他地方修改购物车的数量值改变后的响应事件,刷新视图
-(void)didNotice:(id)sender{
    [self.dataTableView reloadData];
}


-(void)initTableView{
    CGRect rect = self.view.bounds;
    rect.size.height -= 60;
    UITableView *tableView = [[UITableView alloc]initWithFrame:rect];
    _dataTableView = tableView;
    _dataTableView.delegate = self;
    _dataTableView.dataSource = self;
    _dataTableView.rowHeight = 80;
    _dataTableView.tableFooterView = [UIView new];
    [self.view addSubview:_dataTableView];
}

-(void)initBottomView{
    shopCarBottomView *bottomView = [[shopCarBottomView alloc]initWithFrame:CGRectMake(-0.5, self_screen_height-49-60, self_screen_width+1, 60)];
    _bottomView = bottomView;
    
    
    [self.view addSubview:_bottomView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return APPDELEGATE.shopCarArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"shopCarInfoCell";
    shopCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"shopCarInfoCell" owner:nil options:nil]firstObject];
    }
    NSMutableDictionary *dict = APPDELEGATE.shopCarArray[indexPath.row];
    cell.dict = dict;
    cell.index = indexPath.row;
    [cell setupCell];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableDictionary *dict = APPDELEGATE.shopCarArray[indexPath.row];
        int num = [[dict valueForKey:shopCar_Fruit_Num_Key]intValue];
        int price = [[dict valueForKey:shopCar_Fruit_Price_Key]intValue];
        APPDELEGATE.mainTabController.totalNum -= num;
        APPDELEGATE.mainTabController.badgeView.badgeValue = APPDELEGATE.mainTabController.totalNum;
        APPDELEGATE.mainTabController.totalPrice -= (num*price);
        
        //更新bottomView的总量值，价格值
        self.bottomView.l2.text = [NSString stringWithFormat:@"%d",APPDELEGATE.mainTabController.totalNum];
        self.bottomView.l4.text = [NSString stringWithFormat:@"￥%d",APPDELEGATE.mainTabController.totalPrice];
        
        [APPDELEGATE.shopCarArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [APPDELEGATE.shopCarArray writeToFile:APPDELEGATE.shopCarFilePath atomically:YES];
        [self.dataTableView reloadData];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:numChangeFromFruitList object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:numChangeFromDetail object:nil];
}


@end
