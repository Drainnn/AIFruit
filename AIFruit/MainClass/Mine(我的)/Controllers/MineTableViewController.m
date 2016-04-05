//
//  MineTableViewController.m
//  AIFruit
//
//  Created by Kosne on 16/3/29.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "MineTableViewController.h"

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

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];

    
    return cell;
}



@end
