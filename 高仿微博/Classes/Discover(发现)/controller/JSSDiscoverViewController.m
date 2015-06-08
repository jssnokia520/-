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

@end
