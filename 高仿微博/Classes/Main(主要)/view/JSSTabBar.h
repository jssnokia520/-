//
//  JSSTabBar.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/9.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSTabBar;

@protocol JSSTabBarDelegate <UITabBarDelegate>

- (void)tabBarPlusButtonDidTaped:(JSSTabBar *)tabBar;

@end

@interface JSSTabBar : UITabBar

+ (instancetype)tabBar;

@property (nonatomic, weak) id<JSSTabBarDelegate> delegate;

@end
