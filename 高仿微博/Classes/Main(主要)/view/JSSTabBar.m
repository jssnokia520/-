//
//  JSSTabBar.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/9.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSTabBar.h"

@interface JSSTabBar ()

@property (nonatomic, weak) UIButton *button;

@end

@implementation JSSTabBar

- (UIButton *)button
{
    if (_button == nil) {
        UIButton *button = [[UIButton alloc] init];
        
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(tapPlusButton) forControlEvents:UIControlEventTouchUpInside];
        [button setSize:button.currentBackgroundImage.size];
        
        [self addSubview:button];
        _button = button;
    }
    return _button;
}

- (void)tapPlusButton
{
    if ([self.delegate respondsToSelector:@selector(tabBarPlusButtonDidTaped:)]) {
        [self.delegate tabBarPlusButtonDidTaped:self];
    }
}

+ (instancetype)tabBar
{
    return [[self alloc] init];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width / (self.subviews.count -2 + 1);
    Class class = NSClassFromString(@"UITabBarButton");
    NSInteger currentIndex = 0;
    
    for (UIView *childView in self.subviews) {
        if ([childView isKindOfClass:class]) {
            [childView setX:width * currentIndex];
            [childView setWidth:width];
            
            currentIndex++;
            
            if (currentIndex == 2) {
                [self.button setX:width * currentIndex];
                [self.button setWidth:width];
                [self.button setCenterY:self.height * 0.5];
                currentIndex++;
            }
        }
    }
}

@end
