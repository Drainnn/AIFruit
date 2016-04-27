//
//  orderViewController.m
//  AIFruit
//
//  Created by Kosne on 16/4/24.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "orderViewController.h"
#import "orderAddressCell.h"
#import "sendDataCell.h"
#import "payWayCell.h"
#import "billInfoCell.h"
#import "notesCell.h"
#import "orderFruitInfoCell.h"
#import "orderTotalCell.h"
#import "AppDelegate.h"
#import "orderBottomView.h"

@interface orderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) orderBottomView *bottomView;

@end

@implementation orderViewController

-(orderBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[orderBottomView alloc]initWithFrame:CGRectMake(0, self_screen_height-60, self_screen_width, 60)];
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = themeColor;

    [self initTableView];
    [self initBottomView];
}

#pragma mark - 初始化tableView
-(void)initTableView{
    _dataTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _dataTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _dataTableView.delegate = self;
    _dataTableView.dataSource = self;
    _dataTableView.tableFooterView = [UIView new];
    _dataTableView.sectionFooterHeight = 10;
    _dataTableView.backgroundColor = UIColorWithRGB(235, 235, 235);
    _dataTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_dataTableView];
}

-(void)initBottomView{
    [self.view addSubview:self.bottomView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 2;
    }else if(section == 4){
        return APPDELEGATE.shopCarArray.count;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 4 || indexPath.section == 5) {
        return 60;
    }else{
        return 44;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifier = @"orderAddressCell";
        orderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        [cell setupCell];
        return cell;
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString *identifer = @"sendDataCell";
            sendDataCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:identifer owner:nil options:nil]firstObject];
            }
            [cell setupCell];
            return cell;
        }else{
            static NSString *identifer = @"payWayCell";
            payWayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:identifer owner:nil options:nil]firstObject];
            }
            [cell setupCell];
            return cell;
        }
    }else if(indexPath.section == 2){
        static NSString *identifier = @"billInfoCell";
        billInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        [cell setupCell];
        return cell;
    }else if(indexPath.section == 3){
        static NSString *identifier = @"notesCell";
        notesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        [cell setupCell];
        return cell;
    }else if(indexPath.section == 4){
        static NSString *identifier = @"orderFruitInfoCell";
        orderFruitInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        [cell setupCellWithDic:APPDELEGATE.shopCarArray[indexPath.row]];
        return cell;
    }else{
        static NSString *identifier = @"orderTotalCell";
        orderTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil]firstObject];
        }
        [cell setupCell];
        return cell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{

}





@end
