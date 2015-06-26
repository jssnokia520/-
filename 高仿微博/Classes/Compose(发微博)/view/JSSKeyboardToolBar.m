//
//  JSSKeyboardToolBar.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/26.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSKeyboardToolBar.h"

@implementation JSSKeyboardToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]]];
        
        [self addButtonWithNormalImage:[UIImage imageNamed:@"compose_camerabutton_background"] highlightedImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted"]];
        [self addButtonWithNormalImage:[UIImage imageNamed:@"compose_toolbar_picture"] highlightedImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"]];
        [self addButtonWithNormalImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"]];
        [self addButtonWithNormalImage:[UIImage imageNamed:@"compose_trendbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"]];
        [self addButtonWithNormalImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]];
    }
    return self;
}

/**
 *  根据正常图片和高亮图片来添加按钮
 */
- (void)addButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    [self addSubview:button];
}

/**
 *  重新布局子控件位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat width = self.width / count;
    CGFloat height = self.height;
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = self.subviews[i];
        [button setX:width * i];
        [button setY:0];
        [button setWidth:width];
        [button setHeight:height];
    }
}

@end
