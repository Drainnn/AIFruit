//
//  SearchTableViewController.m
//  AIFruit
//
//  Created by Kosne on 16/3/15.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "SearchTableViewController.h"
#import "SearchBarView.h"
#import "SearchHistoryCell.h"
#import "HotRecommendViewCell.h"
#import "SearchListTableViewController.h"
#import "clearSearchCell.h"
#import "AppDelegate.h"

@interface SearchTableViewController ()<UISearchBarDelegate,UITextFieldDelegate>
{
    int InputNum;//搜索框输入字数
    NSString *Inputkeyword;//搜索关键词
    int TapNum;//单击次数
    int oldSearchItem;//上一次的搜索记录条数
}

@property (nonatomic, strong) UIView *TitleSearchView;//搜索背景view(覆盖在titleView上)
@property (nonatomic, strong) UIView *searchBGView;//搜索背景view
@property (nonatomic, strong) UIImageView *IconSearchView;//搜索图标
@property (nonatomic, strong) UILabel *searchLabel;//搜索提示label
@property (nonatomic, strong) UIButton *cancelBtn;//取消按钮
@property (nonatomic, strong) UITextField *searchField;//搜索框
@property (nonatomic, strong) UITapGestureRecognizer *singleRecognizer;

@property (nonatomic, strong) AppDelegate *appdelegate;

@property (nonatomic, strong) NSMutableArray *searchArray;

@end

@implementation SearchTableViewController

-(AppDelegate *)appdelegate{
    if (!_appdelegate) {
        _appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return _appdelegate;
}

-(NSMutableArray *)searchArray{
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
        if (APPDELEGATE.searchRecordArray.count > 0) {
            for (NSDictionary *dic in [APPDELEGATE.searchRecordArray reverseObjectEnumerator]) {
                [_searchArray addObject:dic];
            }
        }
        
    }
    return _searchArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    InputNum = 1;
    TapNum = 0;
    [self addSearchView];
    
    oldSearchItem = (int)self.searchArray.count;
    
//    _searchField.returnKeyType = UIReturnKeySearch;
    
    self.tableView.backgroundColor = BGC_SEARCHTABLEVIEW;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ((int)self.searchArray.count > oldSearchItem) {
        oldSearchItem = (int)self.searchArray.count;
        [self.tableView reloadData];
    }
    
}


#pragma mark - 搜索框视图
-(void)addSearchView{
    _TitleSearchView = [[UIView alloc]init];
    _TitleSearchView.frame = CGRectMake(0, 0, 300, 25);
    //最下面一层的view添加单击事件
    _singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
    _singleRecognizer.numberOfTapsRequired = 1;
    [_TitleSearchView addGestureRecognizer:_singleRecognizer];
    
    _searchBGView = [[UIView alloc]init];
    _searchBGView.frame = CGRectMake(0, 0, 300, 25);
    _searchBGView.backgroundColor = UIColorWithRGBA(106, 203, 93, 0.2);
    _searchBGView.layer.cornerRadius = 12;
    
    [self addIconSearchView];
    [self initSearchLabelWithStatus:1];
    [self addSearchLabel];
    
    
    
    [_TitleSearchView addSubview:_searchBGView];
    self.navigationItem.titleView = _TitleSearchView;
}


#pragma mark - 添加搜索图标
-(void)addIconSearchView{
    _IconSearchView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-search"]];
    //搜索图标的位置
    _IconSearchView.frame = CGRectMake(90, 5, 13, 13);
    [_searchBGView addSubview:_IconSearchView];
}

-(void)initSearchLabelWithStatus:(int)status{
    _searchLabel = [[UILabel alloc]init];
    if (status == 1) {
        //搜索提示文字的位置
        _searchLabel.frame = CGRectMake(110, -2, 230, 30);
    }
    else{
        _searchLabel.frame = CGRectMake(25, -2, 230, 30);
    }
    
    
    _searchLabel.text = @"请输入商品名称";
    _searchLabel.textColor = UIColorWithRGBA(0, 137, 63, 1);
    UIFont *font = UIFontWithSize(14.0f);
    _searchLabel.font = font;
}

//-(void)addSearchLabelWithStatus:(int)status{
//    
//    
//    [_searchBGView addSubview:_searchLabel];
//}

-(void)addSearchLabel{
    [_searchBGView addSubview:_searchLabel];
}

#pragma mark - 搜索框点击事件
-(void)handleSingleTapFrom{
    if (TapNum == 0) {
        [_TitleSearchView removeGestureRecognizer:_singleRecognizer];
        TapNum ++;
    }
    
    //移动视图
    [UIView animateWithDuration:0.2 animations:^{
        _IconSearchView.frame = CGRectMake(10, 5, 13, 13);
        _searchLabel.frame = CGRectMake(25, -2, 230, 30);
//        [_searchLabel removeFromSuperview];
        _searchBGView.frame = CGRectMake(0, 0, 260, 25);
    }];
    
    [self addCancelBtnWithView:_TitleSearchView];
    [self addInputTextField:_TitleSearchView];
}

#pragma mark - 添加取消按钮
-(void)addCancelBtnWithView:(UIView *)view{
    _cancelBtn = [[UIButton alloc]init];
    _cancelBtn.frame = CGRectMake(260, 0, 50, 25);
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:UIColorWithRGBA(0, 137, 63, 1) forState:UIControlStateNormal];
    UIFont *font = UIFontWithSize(14.0f);
    [_cancelBtn.titleLabel setFont:font];
    [_cancelBtn addTarget:self action:@selector(ClickCancel:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_cancelBtn];
}
//取消按钮的点击事件
-(void)ClickCancel:(id)sender{
   
    [_TitleSearchView addGestureRecognizer:_singleRecognizer];
     TapNum = 0;
    
    if (InputNum == 1) {
        [UIView animateWithDuration:0.3 animations:^{
            _IconSearchView.frame = CGRectMake(90, 5, 13, 13);
            _searchLabel.frame = CGRectMake(110, -2, 230, 30);
            _searchBGView.frame = CGRectMake(0, 0, 300, 25);
        }];

    }
    else{
        [_TitleSearchView removeGestureRecognizer:_singleRecognizer];
        [_TitleSearchView removeFromSuperview];
        [_searchBGView removeFromSuperview];
        [_IconSearchView removeFromSuperview];
        [self addSearchView];
        InputNum = 1;
    }
    
    //移除取消按钮
    [_cancelBtn removeFromSuperview];
    //移除搜索输入框
    [_searchField removeFromSuperview];
}



#pragma mark - 添加输入框
-(void)addInputTextField:(UIView *)view{
    _searchField = [[UITextField alloc]init];
    _searchField.frame = CGRectMake(25, 3, 200, 20);
    _searchField.delegate = self;
    [_searchField becomeFirstResponder];
    UIFont *font = UIFontWithSize(14);
    [_searchField setFont:font];
    [_searchField setTextColor:UIColorWithRGBA(0, 137, 63, 1)];
    [_searchField addTarget:self action:@selector(TextFieldChange:) forControlEvents:UIControlEventEditingChanged];
    _searchField.returnKeyType = UIReturnKeySearch;
    
    [view addSubview:_searchField];
}
//输入框值改变事件
-(void)TextFieldChange:(UITextField *)sender{
   
 
    if (sender.text.length == 0) {
        [self addSearchLabel];
    }
    else{
        [_searchLabel removeFromSuperview];
    }

    InputNum = (int)sender.text.length + 1;
    
}

#pragma mark - 点击键盘搜索键
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     SearchListTableViewController *searchListVC = [[UIStoryboard storyboardWithName:@"SearchList" bundle:nil] instantiateViewControllerWithIdentifier:@"SearchListStoryboard"];
    
    [_searchField resignFirstResponder];
    
    Inputkeyword = textField.text;
    searchListVC.keyword = Inputkeyword;
    [self ClickCancel:nil];
    
    
    [self saveSearchRecord:Inputkeyword];
    
    [self.navigationController pushViewController:searchListVC animated:YES];
    return YES;
}

#pragma mark - 保存搜索记录
-(void)saveSearchRecord:(NSString *)search{
    //~~~~~~~~~~~~这里的代码可以优化下~~~~~~~~~~~~
    //搜索记录保存
    
    if (APPDELEGATE.searchRecordArray.count > 0) {
        int isNewKeyword = 1;
        for (NSDictionary *dic in APPDELEGATE.searchRecordArray) {
            NSString *value = dic[searchHistoryKey];
            if ([search isEqualToString:value]) {
                isNewKeyword = 0;
                break;
            }
        }
        //如果关键词不存在则保存
        if (isNewKeyword) {
            NSDictionary *dic = [NSDictionary dictionaryWithObject:search forKey:searchHistoryKey];
            [APPDELEGATE.searchRecordArray addObject:dic];
            [self.appdelegate.searchRecordArray writeToFile:APPDELEGATE.searchRecordFilePath atomically:YES];
            [self.searchArray insertObject:dic atIndex:0];
            
        }
    }else{
        NSDictionary *dic = [NSDictionary dictionaryWithObject:search forKey:searchHistoryKey];
        [APPDELEGATE.searchRecordArray addObject:dic];
        [self.appdelegate.searchRecordArray writeToFile:APPDELEGATE.searchRecordFilePath atomically:YES];
        [self.searchArray insertObject:dic atIndex:0];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.searchArray.count > 0 ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }
    else{
        return self.searchArray.count + 1;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"热门搜索";
    }
    else{
        return @"搜索历史";
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }
    else{
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }
    else{
        if (indexPath.row < self.searchArray.count) {
            return 44;
        }else{
            return 60;
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *identifier = @"HotRecommend";
        HotRecommendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HotRecommendViewCell" owner:nil options:nil]firstObject];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupCell];
        __weak SearchTableViewController *weakSelf = self;
        cell.didtosearchlist = ^(NSString *keyword){
            [weakSelf hotRecommendClicked:keyword];
        };
        return cell;
    }
    else{
        if (indexPath.row < self.searchArray.count) {
            static NSString *identifier = @"SearchHistory";
            SearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"SearchHistoryCell" owner:nil options:nil]firstObject];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary *dic = [self.searchArray objectAtIndex:indexPath.row];
            cell.historyLabel.text = dic[searchHistoryKey];
            //    cell.backgroundColor = UIColorWithRGBA(243, 244, 246, 1);
            cell.backgroundColor = [UIColor whiteColor];
            
            return cell;
        }else{
            static NSString *identifier = @"clearSearchCell";
            clearSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"clearSearchCell" owner:nil options:nil]firstObject];
            }
            __weak SearchTableViewController *weakSelf = self;
            cell.didclearSearchRecord = ^(){
                [weakSelf clearSearch];
            };
            [cell setupCell];
            return cell;
        }
        
    }
    
}

#pragma mark - 热门推荐点击事件
-(void)hotRecommendClicked:(NSString *)keyword{
    [self saveSearchRecord:keyword];
    SearchListTableViewController *searchListVC = [[UIStoryboard storyboardWithName:@"SearchList" bundle:nil] instantiateViewControllerWithIdentifier:@"SearchListStoryboard"];
    searchListVC.keyword = keyword;
    [self.navigationController pushViewController:searchListVC animated:YES];
}

#pragma mark - 点击cell触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }
    else{
        if (indexPath.row < self.searchArray.count) {
            SearchListTableViewController *searchListVC = [[UIStoryboard storyboardWithName:@"SearchList" bundle:nil] instantiateViewControllerWithIdentifier:@"SearchListStoryboard"];
            NSDictionary *dic = [self.searchArray objectAtIndex:indexPath.row];
            NSString *str = dic[searchHistoryKey];
            searchListVC.keyword = str;
            [self.navigationController pushViewController:searchListVC animated:YES];
        }
    }
}

#pragma mark - 点击清除搜索记录的回调， 清除搜索记录
-(void)clearSearch{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:APPDELEGATE.searchRecordFilePath]) {
        [APPDELEGATE.searchRecordArray removeAllObjects];
        [self.searchArray removeAllObjects];
        //删除section
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadData];
        [manager removeItemAtPath:APPDELEGATE.searchRecordFilePath error:nil];
        //设置上一次搜索记录条数为0
        oldSearchItem = 0;
    }
}




#pragma mark - tableviewcell显示完整的分割线
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
//    if (indexPat.section == 1) {
//        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//            [cell setLayoutMargins:UIEdgeInsetsZero];
//        }
//        if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
//            [cell setSeparatorInset:UIEdgeInsetsZero];
//        }
//    }
//   
//}

@end
