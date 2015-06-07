//
//  JSSAppDelegate.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSAppDelegate.h"
#import "JSSTabBarViewController.h"

@implementation JSSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 1.实例化window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 2.设置根控制器
    UITabBarController *tabbarVc = [[JSSTabBarViewController alloc] init];
    [self.window setRootViewController:tabbarVc];
    
    // 3.设置窗口可见
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
