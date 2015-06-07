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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    JSSTest2ViewController *test2 = [[JSSTest2ViewController alloc] init];
    [test2 setTitle:@"测试2控制器"];
    [self.navigationController pushViewController:test2 animated:YES];
}

@end
