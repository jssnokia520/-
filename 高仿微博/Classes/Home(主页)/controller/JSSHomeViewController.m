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
