//
//  JSSNewfeatureViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSNewfeatureViewController.h"
#import "JSSTabBarViewController.h"

@interface JSSNewfeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation JSSNewfeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 添加滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    
    NSInteger pageCount = 4;
    CGFloat width = self.view.width;
    CGFloat height = self.view.height;
    
    [scrollView setFrame:self.view.bounds];
    [scrollView setContentSize:CGSizeMake(width * pageCount, height)];
    [scrollView setDelegate:self];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setBounces:NO];
    
    for (NSInteger i = 0; i < pageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setX:i * width];
        [imageView setSize:scrollView.size];
        NSString *name = [NSString stringWithFormat:@"new_feature_%ld", i + 1];
        [imageView setImage:[UIImage imageNamed:name]];
        [scrollView addSubview:imageView];
        
        if (i == pageCount - 1) {
            [self dealImageView:imageView];
        }
    }
    
    // 添加分页控件
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [pageControl setNumberOfPages:pageCount];
    [pageControl setCurrentPageIndicatorTintColor:JSSColor(255, 109, 0)];
    [pageControl setPageIndicatorTintColor:JSSColor(128, 128, 128)];
    [pageControl setCenterX:width * 0.5];
    [pageControl setCenterY:height - 40];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)dealImageView:(UIImageView *)imageView
{
    // 启用交互功能
    [imageView setUserInteractionEnabled:YES];
    
    // 转发微博
    UIButton *checkBtn = [[UIButton alloc] init];
    
    // 先设置尺寸,再设置位置
    [checkBtn setWidth:150];
    [checkBtn setHeight:30];
    [checkBtn setCenterX:imageView.width * 0.5];
    [checkBtn setCenterY:imageView.height * 0.7];
    
    [checkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [checkBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [checkBtn addTarget:self action:@selector(checkBtnTaped:) forControlEvents:UIControlEventTouchUpInside];
    [checkBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [checkBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [imageView addSubview:checkBtn];
    
    // 开始微博
    UIButton *beginBtn = [[UIButton alloc] init];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [beginBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [beginBtn setSize:beginBtn.currentBackgroundImage.size];
    [beginBtn setCenterX:imageView.width * 0.5];
    [beginBtn setCenterY:imageView.height * 0.8];
    [beginBtn addTarget:self action:@selector(beginBtnTaped) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:beginBtn];
}

- (void)checkBtnTaped:(UIButton *)button
{
    [button setSelected:!button.selected];
}

- (void)beginBtnTaped
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window setRootViewController:[[JSSTabBarViewController alloc] init]];
}

- (void)dealloc
{
    NSLog(@"JSSNewfeatureViewController.h-dealloc");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage =  (NSInteger)(scrollView.contentOffset.x / scrollView.width + 0.5);
    [self.pageControl setCurrentPage:currentPage];
}

@end
