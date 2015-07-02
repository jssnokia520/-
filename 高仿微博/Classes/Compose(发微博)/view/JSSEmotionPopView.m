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

@end
