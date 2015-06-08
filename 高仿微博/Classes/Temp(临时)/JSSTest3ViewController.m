//
//  JSSTest3ViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/8.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSTest3ViewController.h"

@interface JSSTest3ViewController ()

@end

@implementation JSSTest3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 覆盖导航条右边的按钮
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"测试" style:UIBarButtonItemStylePlain target:nil action:nil]];
}

@end
