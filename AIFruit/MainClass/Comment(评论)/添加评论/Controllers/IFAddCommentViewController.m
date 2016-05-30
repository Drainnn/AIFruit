//
//  IFAddCommentViewController.m
//  iFruit
//
//  Created by administrator on 15/8/14.
//  Copyright (c) 2015年 gem. All rights reserved.
//

#import "IFAddCommentViewController.h"
#import "IFGoodsTableViewCell.h"
#import "IFGradeTableViewCell.h"
#import "IFPhotoTableViewCell.h"
#import "JKImagePickerController.h"
#import "IFPictureTableViewCell.h"
//#import "IFMyOrderViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "ZLPhotoPickerBrowserViewController.h"

#define kComment @"http://appifruit.sinaapp.com/iFruit/index.php/Home/Comment/"

@interface IFAddCommentViewController ()<FlowerRatingViewDelegate,IFPhotoTableViewCellDelegate,UIActionSheetDelegate,JKImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,ZLPhotoPickerBrowserViewControllerDelegate,ZLPhotoPickerBrowserViewControllerDataSource,IFPictureTableViewCellDelegate,UITextViewDelegate>
{
    float commentGrade;
    UIView *myView;
    IFPhotoTableViewCell *photoCell;
    NSString *commentID;
    NSInteger indexNum;
    
}
@property (nonatomic, strong) NSMutableArray   *assetsArray;
@end

@implementation IFAddCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViewAndButton];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.tableFooterView = [[UIView alloc] init];
    self.tabBarController.tabBar.hidden = YES;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    commentGrade = 5.0;
    self.title = @"商品评价";
    
    // Do any additional setup after loading the view.
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self_screen_width, 36)];
    customView.backgroundColor = [UIColor lightGrayColor];
    photoCell.commentView.inputAccessoryView = customView;
    photoCell.commentView.delegate = self;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self_screen_width - 60, 0, 60, 36)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:UIColorWithRGBA(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:btn];
    
}

-(void)hideKeyBoard{
    
    if ([photoCell.commentView.text isEqualToString:@""]) {
        photoCell.placeholderLabel.text = @"亲,写点什么吧，您的意见对其他团友有很大帮助！";
        
    }
    [photoCell.commentView resignFirstResponder];
    self.myTableView.frame = CGRectMake(0, 0, self_screen_width, self_screen_height);
}


-(void)addViewAndButton{
    myView = [[UIView alloc]initWithFrame:CGRectMake(0, self_screen_height - 50, self_screen_width, 50)];
    myView.backgroundColor = [UIColor grayColor];
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(self_screen_width/2-50, 10, 100, 30)];
    [myView setBackgroundColor:UIColorWithRGBA(248, 248, 248, 1.0f)];
    [but setTitle:@"发表评论" forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:15];
    but.layer.masksToBounds = YES;
    but.layer.cornerRadius = 8;
    but.layer.backgroundColor = [UIColorWithRGBA(253, 119, 8, 1.0f) CGColor];
    [but addTarget:self action:@selector(saveCommentToDB:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:but];
    [self.view addSubview:myView];
    [self.view bringSubviewToFront:myView];
}

-(void)saveCommentToDB:(UIButton *)sender{
    

    photoCell = (IFPhotoTableViewCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];
    UITextView *contentText = (UITextView *)[photoCell.contentView viewWithTag:501];
    
    if ([contentText.text isEqualToString:@""]) {
        NSString *info = @"亲,写点东西吧。";
        [self setWarnInfor:info];
    }
    else{
        NSLog(@"%@",contentText.text);
        [self saveCommentRequest];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (self.assetsArray.count > 0) {
        return 4;
    }
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 110;
    }
    else if (indexPath.row == 1){
        return 70;
    }
    else if (indexPath.row == 2){
        return 70;
    }
    else{
        if (self.assetsArray.count > 3) {
            return ((self_screen_width - 60) / 3) * 2 + 30;
        }
        else{
        
            return ((self_screen_width - 60) / 3) + 20;
        }
    
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        IFGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setGoodsInfo:_orderDIC];
        return cell;
    }
    else if (indexPath.row == 1){
        
        IFGradeTableViewCell *gradeCell = [tableView dequeueReusableCellWithIdentifier:@"gradeCell"];
        gradeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        gradeCell.ratingView.delegate = self;
        return  gradeCell;
    }else if(indexPath.row == 2){
        photoCell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
        photoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        photoCell.delegate = self;
        return photoCell;
    }else{
        if (self.assetsArray.count > 0) {
            IFPictureTableViewCell *pictureCell = [tableView dequeueReusableCellWithIdentifier:@"pictureCell"];
            pictureCell.delegate = self;
            [pictureCell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [pictureCell showImage:self.assetsArray];
            return pictureCell;
        }
    }
    return  nil;
}


-(void)enterAlbumAndCamera{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"亲，您可上传5张图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    [sheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        NSLog(@"打开相机");
    }
    else if(buttonIndex == 1){
        JKImagePickerController *imagePickerControl = [[JKImagePickerController alloc]init];
        imagePickerControl.delegate = self;
        imagePickerControl.filterType = JKImagePickerControllerFilterTypePhotos;
        imagePickerControl.minimumNumberOfSelection = 0;
        imagePickerControl.maximumNumberOfSelection = 5;
        imagePickerControl.showsCancelButton = YES;
        imagePickerControl.allowsMultipleSelection = YES;
        imagePickerControl.selectedAssetArray = self.assetsArray;
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:imagePickerControl];
        imagePickerControl.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
        [self presentViewController:navigationController animated:YES completion:nil];
        
    }
    
}

-(void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source{
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    [self.myTableView reloadData];
}

-(void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source{
   
    
    self.assetsArray = [NSMutableArray arrayWithArray:assets];
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        [self.myTableView reloadData];
    }];
    
}

-(void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker{
   
    [imagePicker dismissViewControllerAnimated:YES completion:^{
     
    }];
}

-(void)flowerRatingView:(IFRatingView *)view grade:(float)grade{
    commentGrade = grade * 5;
    IFGradeTableViewCell *cell = (IFGradeTableViewCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
    UILabel *scoreLabel = (UILabel *)[cell.contentView viewWithTag:500];
    scoreLabel.text = [NSString stringWithFormat:@"%0.1f",commentGrade];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
    [self.view endEditing:YES];

}


-(void)saveCommentRequest{
//
//    NSString *urlPath = [NSString stringWithFormat:@"%@addcomment",kComment];
////      NSString *urlPath = @"http://localhost:8888/iFruit/index.php/Home/Comment/addcomment";
//    
//    photoCell = (IFPhotoTableViewCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];
//    UITextView *contentText = (UITextView *)[photoCell.contentView viewWithTag:501];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [dateFormatter setTimeZone:timeZone];
//    NSDate *now = [NSDate date];
//    NSInteger interval = [timeZone secondsFromGMTForDate:now];
//    NSDate *localDate = [now dateByAddingTimeInterval:interval];
//    NSString *dateNow = [NSString stringWithFormat:@"%ld",(long)[localDate timeIntervalSince1970]];
//    NSLog(@"%@",dateNow);
//    
//    
//    NSString *userID = [NSString stringWithFormat:@"%ld",(long)APPDELEGATE.user.userID];
//    NSString *goodsID = [_orderDIC valueForKey:@"goods_id"];
//    NSString *orderID = [_orderDIC valueForKey:@"order_id"];
//    NSDictionary *commentDIC = @{
//                                 @"userid":userID,
//                                 @"goodsid":goodsID,
//                                 @"content":contentText.text,
//                                 @"time":dateNow,
//                                 @"grade":[NSString stringWithFormat:@"%0.1f",commentGrade],
//                                 @"orderid":orderID,
//                                 @"recordtime":dateNow
//                                 };
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager POST:urlPath parameters:commentDIC constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//       
//        for (int i = 0; i < [self.assetsArray count]; i++) {
//            JKAssets *asset = [self.assetsArray objectAtIndex:i];
//            UIImage *img = asset.photo;
//            NSString *filename = [NSString stringWithFormat:@"header%d.png",i];
//            NSString *name = [NSString stringWithFormat:@"name%d.png",i];
//            NSData *d =  UIImageJPEGRepresentation(img, 0.1);
//            [formData appendPartWithFileData:d name:name fileName:filename mimeType:@"image/png"];
//        }
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
//        NSString *code = [responseObject valueForKey:@"code"];
//        if ([code isEqualToString:@"200"] || [code isEqualToString:@"300"]) {
//            NSString *info = @"评论成功";
//            [self setWarnInfor:info];
//            [self performSelector:@selector(popViewController) withObject:nil afterDelay:1.0];
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"超时");
//    }];
//    
}

-(void)popViewController{
    
//    for (UINavigationController *orderView in self.navigationController.viewControllers) {
//        if ([orderView isKindOfClass:[IFMyOrderViewController class]]) {
//            [self.navigationController popToViewController:orderView animated:YES];
//        }
//    }
    
    
}

#pragma mark -- 弹出图片浏览器
-(void)showZLPhotoPickerBrowserViewController:(NSInteger)index andImage:(UIView *)view{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow: index-100 inSection:0];
    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 淡入淡出
    pickerBrowser.status = UIViewAnimationAnimationStatusFade;
    // 传入点击图片View的话，会有微信朋友圈照片的风格
    pickerBrowser.toView = view;
    // 数据源/delegate
    pickerBrowser.delegate = self;
    pickerBrowser.dataSource = self;
    // 是否可以删除照片
    pickerBrowser.editing = YES;
    // 当前选中的值
    pickerBrowser.currentIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:0];
    // 展示控制器
    [self presentViewController:pickerBrowser animated:YES completion:nil];
}

#pragma mark - <ZLPhotoPickerBrowserViewControllerDataSource>
- (NSInteger)numberOfSectionInPhotosInPickerBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser{
    return 1;
}

- (NSInteger)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    return self.assetsArray.count;
}

- (ZLPhotoPickerBrowserPhoto *) photoBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    
    JKAssets *imageObj = [self.assetsArray objectAtIndex:indexPath.row];
    UIImage *img = imageObj.photo;
    ZLPhotoPickerBrowserPhoto *photo = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:img];
    return photo;
}

#pragma mark - <ZLPhotoPickerBrowserViewControllerDelegate>
- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > [self.assetsArray count]) return;
    [self.assetsArray removeObjectAtIndex:indexPath.row];
    [self.myTableView reloadData];
}


-(void)textViewDidBeginEditing:(UITextView *)textView{

    photoCell.placeholderLabel.text = @"";
    if (self_screen_height == 480) {
        self.myTableView.frame = CGRectMake(0, -100, self_screen_width, self_screen_height);
    }
    else if (self_screen_height == 568){
     self.myTableView.frame = CGRectMake(0, -50, self_screen_width, self_screen_height);
    
    }
    else{
     self.myTableView.frame = CGRectMake(0, 0, self_screen_width, self_screen_height);
    }
}


#pragma mark -- 显示提示信息
-(void)setWarnInfor:(NSString *)info{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = info;
    hud.margin = 10.f;
    hud.color = [UIColor grayColor];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}


@end
