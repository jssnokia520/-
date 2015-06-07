//
//  JSSAppDelegate.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSAppDelegate.h"
#import "JSSHomeViewController.h"
#import "JSSMessageCenterViewController.h"
#import "JSSDiscoverViewController.h"
#import "JSSProfileViewController.h"

@implementation JSSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 1.实例化window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 2.设置根控制器
    UITabBarController *tabbarVc = [[UITabBarController alloc] init];
    
    // 3.添加子控制器
    JSSHomeViewController *home = [[JSSHomeViewController alloc] init];
    [self createVcWithVc:home title:@"首页" normalImage:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    JSSMessageCenterViewController *messageCenter = [[JSSMessageCenterViewController alloc] init];
    [self createVcWithVc:messageCenter title:@"消息" normalImage:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    JSSDiscoverViewController *discover = [[JSSDiscoverViewController alloc] init];
    [self createVcWithVc:discover title:@"发现" normalImage:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    JSSProfileViewController *profile = [[JSSProfileViewController alloc] init];
    [self createVcWithVc:profile title:@"我" normalImage:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    [tabbarVc addChildViewController:home];
    [tabbarVc addChildViewController:messageCenter];
    [tabbarVc addChildViewController:discover];
    [tabbarVc addChildViewController:profile];
    
    [self.window setRootViewController:tabbarVc];
    
    // 4.设置窗口可见
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)createVcWithVc:(UIViewController *)childVc title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage
{
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSForegroundColorAttributeName] = JSSColor(128, 128, 128);
    NSMutableDictionary *selectedAttribute = [NSMutableDictionary dictionary];
    selectedAttribute[NSForegroundColorAttributeName] = JSSColor(255, 109, 0);
    
    [childVc.view setBackgroundColor:JJSRandomColor];
    [childVc.tabBarItem setTitle:title];
    [childVc.tabBarItem setTitleTextAttributes:attribute forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedAttribute forState:UIControlStateSelected];
    [childVc.tabBarItem setImage:[UIImage imageNamed:normalImage]];
    [childVc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

@end
