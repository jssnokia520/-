//
//  JSSMessageCenterViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSMessageCenterViewController.h"
#import "JSSTest1ViewController.h"

@interface JSSMessageCenterViewController ()

@end

@implementation JSSMessageCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    JSSLog(@"JSSMessageCenterViewController-viewDidLoad");
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)]];
    
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
}

- (void)composeMsg
{
    NSLog(@"composeMsg");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"test-message-%02ld", indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSSTest1ViewController *test1 = [[JSSTest1ViewController alloc] init];
    [test1 setTitle:@"测试1控制器"];
    [self.navigationController pushViewController:test1 animated:YES];
}

@end
