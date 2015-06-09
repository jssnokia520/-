//
//  JSSDropDownMenu.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/8.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSSDropDownMenu : UIView

/**
 *  获取下拉菜单对象
 */
+ (instancetype)menu;

/**
 *  显示下拉菜单
 */
- (void)showFromView:(UIView *)from;

/**
 *  隐藏下拉菜单
 */
- (void)dismiss;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;

/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;

@end
