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
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)]];
}

- (void)setting
{
    JSSTest1ViewController *test1 = [[JSSTest1ViewController alloc] init];
    [test1 setTitle:@"测试1控制器"];
    [self.navigationController pushViewController:test1 animated:YES];
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
    
    [cell.textLabel setText:[NSString stringWithFormat:@"我-测试数据-%02ld", indexPath.row]];
    
    return cell;
}

@end
