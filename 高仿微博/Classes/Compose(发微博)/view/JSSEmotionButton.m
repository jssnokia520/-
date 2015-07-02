//
//  JSSEmotionButton.m
//  高仿微博
//
//  Created by JiShangsong on 15/7/1.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSEmotionButton.h"
#import "JSSEmotion.h"
#import "NSString+Emoji.h"

@implementation JSSEmotionButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

/**
 *  初始化方法
 */
- (void)setup
{
    [self.titleLabel setFont:[UIFont systemFontOfSize:32]];
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

/**
 *  表情模型
 */
- (void)setEmotion:(JSSEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else {
        NSString *emojiString = [NSString emojiWithStringCode:emotion.code];
        [self setTitle:emojiString forState:UIControlStateNormal];
    }
}

@end
