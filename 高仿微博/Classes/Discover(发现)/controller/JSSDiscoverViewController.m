//
//  JSSDiscoverViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSDiscoverViewController.h"
#import "JSSSearchBar.h"

@interface JSSDiscoverViewController ()

@end

@implementation JSSDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    JSSSearchBar *searchBar = [JSSSearchBar searchBar];
    [searchBar setWidth:300];
    [searchBar setHeight:30];
    [self.navigationItem setTitleView:searchBar];
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
    
    [cell.textLabel setText:[NSString stringWithFormat:@"发现-测试数据-%02ld", indexPath.row]];
    
    return cell;
}

@end
