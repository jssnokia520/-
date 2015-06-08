//
//  JSSNavigationController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/8.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSNavigationController.h"

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
        UIButton *backBtn = [[UIButton alloc] init];
        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        [backBtn setSize:backBtn.currentImage.size];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [viewController.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backBtn]];
        
        // 导航条右边按钮
        UIButton *moreBtn = [[UIButton alloc] init];
        [moreBtn setImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [moreBtn setImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        [moreBtn setSize:moreBtn.currentImage.size];
        [moreBtn addTarget:self action:@selector(moreBtn) forControlEvents:UIControlEventTouchUpInside];
        [viewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:moreBtn]];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)moreBtn
{
    [self popToRootViewControllerAnimated:YES];
}

@end
