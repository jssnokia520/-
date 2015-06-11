//
//  UIWindow+Extension.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/11.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "JSSTabBarViewController.h"
#import "JSSNewfeatureViewController.h"

@implementation UIWindow (Extension)

+ (void)switchController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *key = @"CFBundleVersion";
    
    // 获取上次打开的版本
    NSString *lastVersion = [defaults valueForKeyPath:key];
    
    // 获取本次打开的版本
    NSString *currentVersion = infoDict[key];
    
    // 判断是否是新版本
    if ([lastVersion isEqualToString:currentVersion]) { // 两次版本不同
        [window setRootViewController:[[JSSTabBarViewController alloc] init]];
    } else {
        [window setRootViewController:[[JSSNewfeatureViewController alloc] init]];
        
        // 将新版本写入沙盒
        [defaults setValue:currentVersion forKey:key];
        [defaults synchronize];
    }
}

@end
