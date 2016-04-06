//
//  MineTableViewController.m
//  AIFruit
//
//  Created by Kosne on 16/3/29.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "MineTableViewController.h"

#import "MineInfoViewCell.h"

@interface MineTableViewController ()

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.tableFooterView = [[UIView alloc]init];
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

    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MineInfo";
    MineInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
       cell = [[[NSBundle mainBundle] loadNibNamed:@"MineInfoViewCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}



@end
