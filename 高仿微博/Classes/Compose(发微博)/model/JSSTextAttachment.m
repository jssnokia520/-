//
//  JSSTextAttachment.m
//  高仿微博
//
//  Created by JiShangsong on 15/7/3.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSTextAttachment.h"
#import "JSSEmotion.h"

@implementation JSSTextAttachment

/**
 *  表情模型
 */
- (void)setEmotion:(JSSEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}

@end
