//
//  JSSNewfeatureViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSNewfeatureViewController.h"

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
    
    [scrollView setFrame:self.view.bounds];
    [scrollView setContentSize:CGSizeMake(self.view.width * 4, self.view.height)];
    [scrollView setDelegate:self];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setBounces:NO];
    
    for (NSInteger i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setX:i * scrollView.width];
        [imageView setSize:scrollView.size];
        NSString *name = [NSString stringWithFormat:@"new_feature_%ld", i + 1];
        [imageView setImage:[UIImage imageNamed:name]];
        [scrollView addSubview:imageView];
    }
    
    // 添加分页控件
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [pageControl setNumberOfPages:4];
    [pageControl setCurrentPageIndicatorTintColor:JSSColor(255, 109, 0)];
    [pageControl setPageIndicatorTintColor:JSSColor(128, 128, 128)];
    [pageControl setCenterX:scrollView.width * 0.5];
    [pageControl setCenterY:scrollView.height - 40];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage =  (NSInteger)(scrollView.contentOffset.x / scrollView.width + 0.5);
    [self.pageControl setCurrentPage:currentPage];
}

@end
