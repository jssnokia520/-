//
//  JSSEmotionContentView.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/30.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSEmotionContentView.h"
#import "JSSEmotion.h"
#import "JSSEmotionButton.h"
#import "JSSEmotionPopView.h"

#define JSSContentInset 10
#define JSSCountPerRow 7
#define JSSCountPerCol 3

@interface JSSEmotionContentView ()

@property (nonatomic, strong) JSSEmotionPopView *popView;

@end

@implementation JSSEmotionContentView

/**
 *  懒加载弹出视图
 */
- (JSSEmotionPopView *)popView
{
    if (_popView == nil) {
        _popView = [JSSEmotionPopView popView];
    }
    return _popView;
}

/**
 *  内容视图上的图像数组
 */
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 根据emotions的数目创建按钮
    for (NSInteger i = 0; i < emotions.count; i++) {
        JSSEmotionButton *button = [[JSSEmotionButton alloc] init];
        button.emotion = emotions[i];
        
        [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

/**
 *  按钮监听方法
 */
- (void)buttonDidClick:(JSSEmotionButton *)button
{

    [self.popView setEmotion:button.emotion];
    
    // 获取最后一个窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];

    // 转移坐标系 (将按钮的坐标转移到窗口)
    CGRect frame = [button convertRect:button.bounds toView:window];
    
    CGFloat buttonW = button.width;
    CGFloat buttonH = button.height;
    
    // 设置弹出视图的frame
    [self.popView setCenterX:frame.origin.x + buttonW / 2];
    [self.popView setCenterY:frame.origin.y + buttonH / 2 - self.popView.height / 2];
    
    [window addSubview:self.popView];
    
    // 一定时间后移除弹出视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
}

/**
 *  重新布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttomW = (self.width - 2 * JSSContentInset) / JSSCountPerRow;
    CGFloat buttonH = (self.height - 2 * JSSContentInset) / JSSCountPerCol;
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        [button setX:JSSContentInset + buttomW * (i % JSSCountPerRow)];
        [button setY:JSSContentInset + buttonH * (i / JSSCountPerRow)];
        [button setWidth:buttomW];
        [button setHeight:buttonH];
    }
}

@end
