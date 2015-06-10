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
#import "JSSOAuthViewController.h"

@implementation JSSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 1.实例化window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 2.设置根控制器
    [self.window setRootViewController:[[JSSOAuthViewController alloc] init]];
    
//    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *key = @"CFBundleVersion";
//    // 获取上次打开的版本
//    NSString *lastVersion = [defaults valueForKeyPath:key];
//    
//    // 获取本次打开的版本
//    NSString *currentVersion = infoDict[key];
//    
//    // 3.判断是否是新版本
//    if ([lastVersion isEqualToString:currentVersion]) { // 两次版本不同
//        [self.window setRootViewController:[[JSSTabBarViewController alloc] init]];
//    } else {
//        [self.window setRootViewController:[[JSSNewfeatureViewController alloc] init]];
//        
//        // 将新版本写入沙盒
//        [defaults setValue:currentVersion forKey:key];
//        [defaults synchronize];
//    }
    
    
    // 4.设置窗口可见
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
