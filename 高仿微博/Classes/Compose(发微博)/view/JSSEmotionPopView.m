//
//  JSSEmotionPopView.m
//  高仿微博
//
//  Created by JiShangsong on 15/7/1.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSEmotionPopView.h"
#import "JSSEmotionButton.h"

@interface JSSEmotionPopView ()

/**
 *  表情按钮
 */
@property (weak, nonatomic) IBOutlet JSSEmotionButton *emotionButton;

@end

@implementation JSSEmotionPopView

/**
 *  快速创建弹出视图
 */
+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JSSEmotionPopView" owner:nil options:nil] lastObject];
}

/**
 *  拦截表情模型
 */
- (void)setEmotion:(JSSEmotion *)emotion
{
    _emotion = emotion;
    
    [self.emotionButton setEmotion:emotion];
}

/**
 *  利用按钮来展示弹出动画
 */
- (void)showFromButton:(JSSEmotionButton *)button
{
    [self setEmotion:button.emotion];
    
    // 获取最后一个窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 转移坐标系 (将按钮的坐标转移到窗口)
    CGRect frame = [button convertRect:button.bounds toView:window];
    
    CGFloat buttonW = button.width;
    CGFloat buttonH = button.height;
    
    // 设置弹出视图的frame
    [self setCenterX:frame.origin.x + buttonW / 2];
    [self setCenterY:frame.origin.y + buttonH / 2 - self.height / 2];
    
    [window addSubview:self];
}

@end
