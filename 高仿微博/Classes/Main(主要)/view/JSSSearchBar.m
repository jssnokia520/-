//
//  JSSSearchBar.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/8.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSSearchBar.h"

@implementation JSSSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackground:[UIImage imageNamed:@"searchbar_textfield_background"]];
        [self setPlaceholder:@"请输入搜索条件"];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setSize:CGSizeMake(30, 30)];
        [imageView setImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        // 设置图像视图中得内容模式
        [imageView setContentMode:UIViewContentModeCenter];
        // 设置文本框左边视图的视图模式
        [self setLeftViewMode:UITextFieldViewModeAlways];
        [self setLeftView:imageView];
    }
    
    return self;
}

// 自定义textField来实现搜索框
+ (instancetype)searchBar
{
    return [[self alloc] init];
}

@end
