//
//  JSSTest2ViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/8.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSTest2ViewController.h"
#import "JSSTest3ViewController.h"

@interface JSSTest2ViewController ()

@end

@implementation JSSTest2ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    JSSTest3ViewController *test3 = [[JSSTest3ViewController alloc] init];
    [test3 setTitle:@"测试3控制器"];
    [self.navigationController pushViewController:test3 animated:YES];
}

@end
