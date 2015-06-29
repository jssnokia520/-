//
//  JSSEmotionTabBarView.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/29.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSEmotionTabBarView.h"
#import "JSSEmotionTabBarButton.h"

@interface JSSEmotionTabBarView ()

@property (nonatomic, weak) JSSEmotionTabBarButton *leftButton;
@property (nonatomic, weak) JSSEmotionTabBarButton *rightButton;
@property (nonatomic, weak) JSSEmotionTabBarButton *defaultButton;

@property (nonatomic, weak) JSSEmotionTabBarButton *selectedButton;

@end

@implementation JSSEmotionTabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        JSSEmotionTabBarButton *leftButton = [self addButtonWithTitle:@"最近" emotionTabBarViewButtonType:emotionTabBarViewButtonLatest];
        self.leftButton = leftButton;
        
        JSSEmotionTabBarButton *defaultButton = [self addButtonWithTitle:@"默认" emotionTabBarViewButtonType:emotionTabBarViewButtonDefault];
        self.defaultButton = defaultButton;
        
        [self addButtonWithTitle:@"Emoji" emotionTabBarViewButtonType:emotionTabBarViewButtonEmoji];
        
        JSSEmotionTabBarButton *rightButton = [self addButtonWithTitle:@"浪小花" emotionTabBarViewButtonType:emotionTabBarViewButtonFlower];
        self.rightButton = rightButton;
    }
    return self;
}

/**
 *  拦截代理
 */
- (void)setDelegate:(id<JSSEmotionTabBarViewDelegate>)delegate
{
    _delegate = delegate;
    
    [self buttonDidClick:self.defaultButton];
}

/**
 *  添加按钮
 */
- (JSSEmotionTabBarButton *)addButtonWithTitle:(NSString *)title emotionTabBarViewButtonType:(emotionTabBarViewButtonType)emotionTabBarViewButtonType
{
    JSSEmotionTabBarButton *button = [[JSSEmotionTabBarButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTag:emotionTabBarViewButtonType];
    [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return button;
}

/**
 *  按钮监听方法
 */
- (void)buttonDidClick:(JSSEmotionTabBarButton *)button
{
    [self.selectedButton setEnabled:YES];
    self.selectedButton = button;
    [self.selectedButton setEnabled:NO];
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBarView:emotionTabBarViewButtonType:)]) {
        [self.delegate emotionTabBarView:self emotionTabBarViewButtonType:(int)button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat width = self.width / count;
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = self.subviews[i];
        [button setX:i * width];
        [button setY:0];
        [button setWidth:width];
        [button setHeight:self.height];
    }
    
    for (UIButton *button in self.subviews) {
        if (self.leftButton == button) {
            [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_left_selected"] forState:UIControlStateDisabled];
        } else if (self.rightButton == button) {
            [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_right_selected"] forState:UIControlStateDisabled];
        } else {
            [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_selected"] forState:UIControlStateDisabled];
        }
    }
}

@end
