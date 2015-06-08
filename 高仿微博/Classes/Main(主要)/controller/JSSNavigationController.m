//
//  JSSNavigationController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/8.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSNavigationController.h"
#import "JSSItemTool.h"

@interface JSSNavigationController ()

@end

@implementation JSSNavigationController

/**
 *  拦截导航控制器的PUSH操作
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        // 隐藏底部的tabBar
        [viewController setHidesBottomBarWhenPushed:YES];
        
        // 导航条左边按钮
        [viewController.navigationItem setLeftBarButtonItem:[JSSItemTool itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted"]];
        
        // 导航条右边按钮
        [viewController.navigationItem setRightBarButtonItem:[JSSItemTool itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted"]];
    }
    
    // 调用父类的方法进行PUSH操作
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
