//
//  JSSTest1ViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/8.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSTest1ViewController.h"
#import "JSSTest2ViewController.h"

@interface JSSTest1ViewController ()

@end

@implementation JSSTest1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 导航条左边按钮
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
    [backBtn setSize:backBtn.currentImage.size];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backBtn]];
    
    // 导航条右边按钮
    UIButton *moreBtn = [[UIButton alloc] init];
    [moreBtn setImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
    [moreBtn setSize:moreBtn.currentImage.size];
    [moreBtn addTarget:self action:@selector(moreBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:moreBtn]];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    JSSTest2ViewController *test2 = [[JSSTest2ViewController alloc] init];
    [test2 setTitle:@"测试2控制器"];
    [self.navigationController pushViewController:test2 animated:YES];
}

@end
