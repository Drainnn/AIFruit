//
//  bannerSrcollView.m
//  AIFruit
//
//  Created by Kosne on 16/3/25.
//  Copyright © 2016年 Kosne. All rights reserved.
//

#import "bannerSrcollView.h"
#import "UIImageView+WebCache.h"

//scrollView宽度
#define scrollWidth self.frame.size.width
//scrollView高度
#define scrollHeight self.frame.size.height

#define pageColor UIColorWithRGBA(67,199,176,1.0f)


@interface bannerSrcollView () <UIScrollViewDelegate>

@property (nonatomic, copy) NSArray *imageArray;

@end


@implementation bannerSrcollView
{
    
    __weak UIImageView *_leftImageView,*_centerImageView,*_rightImageView;
    
    __weak UIScrollView *_scrollView;
    
    __weak UIPageControl *_pageControl;
    
    NSTimer *_timer;
    
    //当前索引位置
    NSInteger _currentIndex;
    
    //图片个数
    NSInteger _MaxImageCount;
    
}


-(instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray *)imageArray{
    
    if (imageArray.count < 2) {
        return nil;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createScrollView];
        
        [self setImageArray:imageArray];
        
        [self setMaxImageCount:_imageArray.count];
    }
    
    return self;
}

-(void)setMaxImageCount:(NSInteger)MaxImageCount
{
    _MaxImageCount = MaxImageCount;
    
    /** 复用imageView初始化*/
    [self initImageView];
    
    /** pageControl*/
    [self createPageControl];
    
    /** 定时器*/
    [self setupTimer];
    
    /** 初始化图片位置*/
    [self changeImageLeft:_MaxImageCount-1 andCenter:0 andRight:1];
}

-(void)setImageArray:(NSArray *)imageArray{
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:imageArray.count];
    for (NSString *imageName in imageArray) {
        [imageArr addObject:[UIImage imageNamed:imageName]];
    }
    _imageArray = [imageArr copy];
}

-(void)createScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:scrollView];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    scrollView.contentSize = CGSizeMake(scrollWidth * 3, 0);
    
    _scrollDelayTime = 2;
    
    _currentIndex = 0;
    
    _scrollView = scrollView;
}

-(void)initImageView {
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, scrollWidth, scrollHeight)];
    UIImageView *centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(scrollWidth, 0, scrollWidth, scrollHeight)];
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(scrollWidth * 2, 0, scrollWidth, scrollHeight)];
    
    centerImageView.userInteractionEnabled = YES;
    
    [_scrollView addSubview:leftImageView];
    [_scrollView addSubview:centerImageView];
    [_scrollView addSubview:rightImageView];
    
    _leftImageView = leftImageView;
    _centerImageView = centerImageView;
    _rightImageView = rightImageView;
    
}

-(void)createPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, scrollHeight - 16, scrollWidth, 8)];
    
    //设置指示器的颜色
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    //设置当期页面指示器的颜色
    pageControl.currentPageIndicatorTintColor = pageColor;
    pageControl.numberOfPages = _MaxImageCount;
    pageControl.currentPage = 0;
    
    [self addSubview:pageControl];
    _pageControl = pageControl;
}

#pragma mark - 定时器
-(void)setupTimer{
    if (_scrollDelayTime <  0.5)
        return;
    
    _timer = [NSTimer timerWithTimeInterval:_scrollDelayTime target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)removeTimer{
    if (_timer == nil) {
        return;
    }
    
    [_timer invalidate];
    _timer = nil;
}

-(void)scroll{
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + scrollWidth, 0) animated:YES];
}


-(void)changeImageLeft:(NSInteger)leftIndex andCenter:(NSInteger)centerIndex andRight:(NSInteger)rightIndex{
//    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[leftIndex]] placeholderImage:_placeholderImage];
//    
//    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[centerIndex]] placeholderImage:nil];
//    
//    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[rightIndex]] placeholderImage:nil];
    
    _leftImageView.image = _imageArray[leftIndex];
    _centerImageView.image = _imageArray[centerIndex];
    _rightImageView.image = _imageArray[rightIndex];
    
    [_scrollView setContentOffset:CGPointMake(scrollWidth, 0)];
}

#pragma mark - 滚动代理
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setupTimer];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self changeImageWithOffset:scrollView.contentOffset.x];
}

-(void)changeImageWithOffset:(CGFloat)offsetX{
    if (offsetX >= scrollWidth * 2) {
        _currentIndex++;
        
        if (_currentIndex == _MaxImageCount - 1) {
            [self changeImageLeft:_currentIndex-1 andCenter:_currentIndex andRight:0];
        }else if (_currentIndex == _MaxImageCount){
            _currentIndex = 0;
            [self changeImageLeft:_MaxImageCount-1 andCenter:0 andRight:1];
        }else{
            [self changeImageLeft:_currentIndex-1 andCenter:_currentIndex andRight:_currentIndex+1];
        }
        _pageControl.currentPage = _currentIndex;
    }
    
    if (offsetX <= 0) {
        _currentIndex--;
        if (_currentIndex == 0) {
            [self changeImageLeft:_MaxImageCount-1 andCenter:0 andRight:1];
        }else if (_currentIndex == -1){
            _currentIndex = _MaxImageCount - 1;
            [self changeImageLeft:_currentIndex-1 andCenter:_currentIndex andRight:0];
        }else{
            [self changeImageLeft:_currentIndex-1 andCenter:_currentIndex andRight:_currentIndex+1];
        }
        _pageControl.currentPage = _currentIndex;
    }
}

-(void)dealloc{
    [self removeTimer];
}


-(void)setAutoScrollDelay:(NSTimeInterval)scrollDelayTime{
    _scrollDelayTime = scrollDelayTime;
    [self removeTimer];
    [self setupTimer];
}

@end
