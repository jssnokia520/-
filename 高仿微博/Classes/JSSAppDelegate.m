//
//  JSSAppDelegate.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSAppDelegate.h"

@implementation JSSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 1.实例化window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 2.设置根控制器
    UITabBarController *tabbarVc = [[UITabBarController alloc] init];
    
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSForegroundColorAttributeName] = JSSColor(128, 128, 128);
    NSMutableDictionary *selectedAttribute = [NSMutableDictionary dictionary];
    selectedAttribute[NSForegroundColorAttributeName] = JSSColor(255, 109, 0);
    
    // 3.添加子控制器
    UIViewController *vc1 = [[UIViewController alloc] init];
    [vc1.view setBackgroundColor:JJSRandomColor];
    [vc1.tabBarItem setTitle:@"首页"];
    [vc1.tabBarItem setTitleTextAttributes:attribute forState:UIControlStateNormal];
    [vc1.tabBarItem setTitleTextAttributes:selectedAttribute forState:UIControlStateSelected];
    [vc1.tabBarItem setImage:[UIImage imageNamed:@"tabbar_home"]];
    [vc1.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    [vc2.view setBackgroundColor:JJSRandomColor];
    [vc2.tabBarItem setTitle:@"消息"];
    [vc2.tabBarItem setTitleTextAttributes:attribute forState:UIControlStateNormal];
    [vc2.tabBarItem setTitleTextAttributes:selectedAttribute forState:UIControlStateSelected];
    [vc2.tabBarItem setImage:[UIImage imageNamed:@"tabbar_message_center"]];
    [vc2.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_message_center_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    [vc3.view setBackgroundColor:JJSRandomColor];
    [vc3.tabBarItem setTitle:@"发现"];
    [vc3.tabBarItem setTitleTextAttributes:attribute forState:UIControlStateNormal];
    [vc3.tabBarItem setTitleTextAttributes:selectedAttribute forState:UIControlStateSelected];
    [vc3.tabBarItem setImage:[UIImage imageNamed:@"tabbar_discover"]];
    [vc3.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    [vc4.view setBackgroundColor:JJSRandomColor];
    [vc4.tabBarItem setTitle:@"我"];
    [vc4.tabBarItem setTitleTextAttributes:attribute forState:UIControlStateNormal];
    [vc4.tabBarItem setTitleTextAttributes:selectedAttribute forState:UIControlStateSelected];
    [vc4.tabBarItem setImage:[UIImage imageNamed:@"tabbar_profile"]];
    [vc4.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [tabbarVc setViewControllers:@[vc1, vc2, vc3, vc4]];
    
    [self.window setRootViewController:tabbarVc];
    
    // 4.设置窗口可见
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
