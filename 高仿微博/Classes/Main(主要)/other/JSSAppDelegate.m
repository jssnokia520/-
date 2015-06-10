//
//  JSSAppDelegate.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSAppDelegate.h"
#import "JSSTabBarViewController.h"
#import "JSSNewfeatureViewController.h"

@implementation JSSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 1.实例化window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 2.设置根控制器
    // UITabBarController *tabbarVc = [[JSSTabBarViewController alloc] init];
    // [self.window setRootViewController:tabbarVc];
    
    JSSNewfeatureViewController *controller = [[JSSNewfeatureViewController alloc] init];
    [self.window setRootViewController:controller];
    
    // 3.设置窗口可见
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
