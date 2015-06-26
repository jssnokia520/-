//
//  JSSTabBarViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/8.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSTabBarViewController.h"
#import "JSSHomeViewController.h"
#import "JSSMessageCenterViewController.h"
#import "JSSDiscoverViewController.h"
#import "JSSProfileViewController.h"
#import "JSSNavigationController.h"
#import "JSSTabBar.h"
#import "JSSComposeViewController.h"

@interface JSSTabBarViewController () <JSSTabBarDelegate>

@end

@implementation JSSTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加子控制器
    JSSHomeViewController *home = [[JSSHomeViewController alloc] init];
    [self createVcWithVc:home title:@"首页" normalImage:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    JSSMessageCenterViewController *messageCenter = [[JSSMessageCenterViewController alloc] init];
    [self createVcWithVc:messageCenter title:@"消息" normalImage:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    JSSDiscoverViewController *discover = [[JSSDiscoverViewController alloc] init];
    [self createVcWithVc:discover title:@"发现" normalImage:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    JSSProfileViewController *profile = [[JSSProfileViewController alloc] init];
    [self createVcWithVc:profile title:@"我" normalImage:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    // KVC
    JSSTabBar *tabBar = [JSSTabBar tabBar];
    [tabBar setDelegate:self];
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)tabBarPlusButtonDidTaped:(JSSTabBar *)tabBar
{
    JSSComposeViewController *composeVC = [[JSSComposeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)createVcWithVc:(UIViewController *)childVc title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage
{
    // 设置标题
    [childVc setTitle:title];
    // [childVc.view setBackgroundColor:JJSRandomColor];
    
    // 设置文字
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSForegroundColorAttributeName] = JSSColor(128, 128, 128);
    NSMutableDictionary *selectedAttribute = [NSMutableDictionary dictionary];
    selectedAttribute[NSForegroundColorAttributeName] = JSSColor(255, 109, 0);
    [childVc.tabBarItem setTitleTextAttributes:attribute forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedAttribute forState:UIControlStateSelected];
    
    // 设置图片
    [childVc.tabBarItem setImage:[UIImage imageNamed:normalImage]];
    [childVc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 创建导航控制器并设置导航控制器的根控制器
    JSSNavigationController *nav = [[JSSNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
