//
//  JSSHomeViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSHomeViewController.h"

@interface JSSHomeViewController ()

@end

@implementation JSSHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 导航条左边按钮
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"]];
    
    // 导航条右边按钮
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"]];
    

    
    // 自定义按钮代替导航条的标题视图
    UIButton *titleButton = [[UIButton alloc] init];
    [titleButton setWidth:200];
    [titleButton setHeight:30];
    
    [titleButton addTarget:self action:@selector(downMunu) forControlEvents:UIControlEventTouchUpInside];
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, 0)];
    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    
    [self.navigationItem setTitleView:titleButton];
}

- (void)downMunu
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 添加蒙板
    UIView *cover = [[UIView alloc] initWithFrame:window.bounds];
    [window addSubview:cover];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"popover_background"];
    [imageView setX:50];
    [imageView setY:64];
    [imageView setWidth:217];
    [imageView setHeight:217];
    [imageView setImage:image];
    
    [window addSubview:imageView];
}

- (void)friendsearch
{
    NSLog(@"friendsearch");
}

- (void)pop
{
    NSLog(@"pop");
}

@end
