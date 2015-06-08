//
//  JSSDiscoverViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSDiscoverViewController.h"

@interface JSSDiscoverViewController ()

@end

@implementation JSSDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    JSSLog(@"JSSDiscoverViewController-viewDidLoad");
    
    // 通过系统自带的searchBar不能达到想要的目的.
    // UISearchBar *searchBar = [[UISearchBar alloc] init];
    // [searchBar setScopeBarBackgroundImage:[UIImage imageNamed:@"searchbar_textfield_background"]];
    // [self.navigationItem setTitleView:searchBar];
    
    // 自定义textField来实现搜索框
    UITextField *textField = [[UITextField alloc] init];
    [textField setSize:CGSizeMake(300, 30)];
    [textField setBackground:[UIImage imageNamed:@"searchbar_textfield_background"]];
    [textField setPlaceholder:@"请输入搜索条件"];
    [self.navigationItem setTitleView:textField];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setSize:CGSizeMake(30, 30)];
    [imageView setImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    // 设置图像视图中得内容模式
    [imageView setContentMode:UIViewContentModeCenter];
    // 设置文本框左边视图的视图模式
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField setLeftView:imageView];
}

@end
