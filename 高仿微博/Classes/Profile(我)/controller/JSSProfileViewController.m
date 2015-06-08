//
//  JSSProfileViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSProfileViewController.h"
#import "JSSTest1ViewController.h"

@interface JSSProfileViewController ()

@end

@implementation JSSProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem itemWithTarget:self action:@selector(setting) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"]];
}

- (void)setting
{
    JSSTest1ViewController *test1 = [[JSSTest1ViewController alloc] init];
    [test1 setTitle:@"测试1控制器"];
    [self.navigationController pushViewController:test1 animated:YES];
}

@end
