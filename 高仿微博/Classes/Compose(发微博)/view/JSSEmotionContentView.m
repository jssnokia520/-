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
@property (nonatomic, weak) UIButton *deleteButton;

@end

@implementation JSSEmotionContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(buttonDidDelete) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton = deleteButton;
        [self addSubview:deleteButton];
        
        // 添加手势监听
        UILongPressGestureRecognizer *longRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longRecognizer];
    }
    
    return self;
}

/**
 *  获得长按手势点中的按钮
 */
- (JSSEmotionButton *)buttonWithPoint:(CGPoint)point
{
    for (NSInteger i = 0; i < self.subviews.count - 1; i++) {
        JSSEmotionButton *button = self.subviews[i + 1];
        if (CGRectContainsPoint(button.frame, point)) {
            return button;
        }
    }
    
    return nil;
}

/**
 *  手势监听方法
 */
- (void)longPress:(UILongPressGestureRecognizer *)longRecognizer
{
    CGPoint point = [longRecognizer locationInView:self];

    JSSEmotionButton *button = [self buttonWithPoint:point];
    
    switch (longRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            [self.popView showFromButton:button];
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            [self.popView removeFromSuperview];
            // 发送通知
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            userInfo[@"emotion"] = button.emotion;
            [JSSNotificationCenter postNotificationName:JSSEmotionDidSelected object:nil userInfo:userInfo];
        }
            break;
            
        default:
            break;
    }
}

/**
 *  删除按钮监听方法
 */
- (void)buttonDidDelete
{
    [JSSNotificationCenter postNotificationName:JSSEmotionDidDeleted object:nil];
}

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
    [self.popView showFromButton:button];
    
    // 一定时间后移除弹出视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    // 发送通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"emotion"] = button.emotion;
    [JSSNotificationCenter postNotificationName:JSSEmotionDidSelected object:nil userInfo:userInfo];
}

/**
 *  重新布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttomW = (self.width - 2 * JSSContentInset) / JSSCountPerRow;
    CGFloat buttonH = (self.height - 2 * JSSContentInset) / JSSCountPerCol;
    for (NSInteger i = 0; i < self.subviews.count - 1; i++) {
        UIButton *button = self.subviews[i + 1];
        [button setX:JSSContentInset + buttomW * (i % JSSCountPerRow)];
        [button setY:JSSContentInset + buttonH * (i / JSSCountPerRow)];
        [button setWidth:buttomW];
        [button setHeight:buttonH];
    }
    
    [self.deleteButton setX:self.width - JSSContentInset - buttomW];
    [self.deleteButton setY:self.height - JSSContentInset - buttonH];
    [self.deleteButton setWidth:buttomW];
    [self.deleteButton setHeight:buttonH];
}

@end
