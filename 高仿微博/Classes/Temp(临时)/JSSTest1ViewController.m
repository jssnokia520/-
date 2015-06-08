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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    JSSTest2ViewController *test2 = [[JSSTest2ViewController alloc] init];
    [test2 setTitle:@"测试2控制器"];
    [self.navigationController pushViewController:test2 animated:YES];
}

@end
