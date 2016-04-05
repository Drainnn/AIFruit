
//
//  HomeTableViewController.m
//  AIFruit
//
//  Created by Kosne on 16/3/14.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "HomeTableViewController.h"

#import "bannerViewCell.h"

@interface HomeTableViewController ()

@property (nonatomic, copy) NSArray *imgArr;

@end

@implementation HomeTableViewController

-(NSArray *)imgArr{
    if (!_imgArr) {
        _imgArr = @[@"JAVA.jpg",@"JAVA_1.jpg",@"JAVA_2.jpg"];
    }
    return _imgArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFont *font = UIFontWithSize(16);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : themeColor,NSFontAttributeName : font}];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
    NSArray *array = @[@"ni",@"hao",@"ke"];
    NSLog(@"%@",array[1]);
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 132;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"bannerCell";
    bannerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"bannerViewCell" owner:nil options:nil] firstObject];
    }
    NSLog(@"%@",self.imgArr);
    [cell setupCellWithImages:self.imgArr];
    return cell;
}




@end
