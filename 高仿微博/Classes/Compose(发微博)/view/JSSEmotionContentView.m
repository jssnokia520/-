//
//  JSSEmotionContentView.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/30.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSEmotionContentView.h"
#import "JSSEmotion.h"
#import "NSString+Emoji.h"

#define JSSContentInset 10
#define JSSCountPerRow 7
#define JSSCountPerCol 3

@implementation JSSEmotionContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/**
 *  内容视图上的图像数组
 */
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 根据emotions的数目创建按钮
    for (NSInteger i = 0; i < emotions.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button.titleLabel setFont:[UIFont systemFontOfSize:32]];
        JSSEmotion *emotion = emotions[i];
        
        if (emotion.png) {
            [button setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        } else {
            NSString *emojiString = [NSString emojiWithStringCode:emotion.code];
            [button setTitle:emojiString forState:UIControlStateNormal];
        }
        
        [self addSubview:button];
    }
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
