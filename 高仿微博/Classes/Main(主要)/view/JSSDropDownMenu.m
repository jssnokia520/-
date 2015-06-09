//
//  JSSDropDownMenu.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/8.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSDropDownMenu.h"

@interface JSSDropDownMenu ()

@property (nonatomic, weak) UIImageView *containerView;

@end

@implementation JSSDropDownMenu

- (UIImageView *)containerView
{
    if (_containerView == nil) {
        UIImageView *containerView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"popover_background"];
        [containerView setImage:image];
        [self addSubview:containerView];
        _containerView = containerView;
    }
    
    return _containerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清空蒙板背景颜色
        [self setBackgroundColor:[UIColor clearColor]];
        // 允许用户交互
        [self.containerView setUserInteractionEnabled:YES];
    }
    return self;
}

/**
 *  获取下拉菜单对象
 */
+ (instancetype)menu
{
    return [[self alloc] init];
}

/**
 *  显示下拉菜单
 */
- (void)showFromView:(UIView *)from
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 设置蒙板大小
    [self setFrame:window.bounds];
    [window addSubview:self];
    
    // 设置内容视图的位置
    // 转换坐标系
    CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
}

/**
 *  隐藏下拉菜单
 */
- (void)dismiss
{
    [self removeFromSuperview];
}

/**
 *  内容
 */
- (void)setContent:(UIView *)content
{
    _content = content;
    
    content.x = 10;
    content.y = 15;
    
    // 内容容器的高度
    self.containerView.height = content.height + 25;
    self.containerView.width = content.width + content.x * 2;
    
    [self.containerView addSubview:content];
}

/**
 *  内容控制器
 */
- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    
    self.content = contentController.view;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

@end
