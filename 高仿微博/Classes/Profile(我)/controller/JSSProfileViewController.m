//
//  JSSProfileViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSProfileViewController.h"
#import "JSSTest1ViewController.h"
#import "JSSSearchBar.h"

@interface JSSProfileViewController ()

@end

@implementation JSSProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    JSSLog(@"JSSProfileViewController-viewDidLoad");
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)]];
    
    JSSSearchBar *searchBar = [JSSSearchBar searchBar];
    [searchBar setWidth:200];
    [searchBar setHeight:30];
    [self.view addSubview:searchBar];
}

- (void)setting
{
    JSSTest1ViewController *test1 = [[JSSTest1ViewController alloc] init];
    [test1 setTitle:@"测试1控制器"];
    [self.navigationController pushViewController:test1 animated:YES];
}

@end
