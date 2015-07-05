//
//  JSSEmotionTool.m
//  高仿微博
//
//  Created by JiShangsong on 15/7/4.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSEmotionTool.h"
#import "MJExtension.h"
#import "JSSEmotion.h"

#define JSSEmotionsPath    [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

@implementation JSSEmotionTool

static NSMutableArray *_emotions;

+ (void)initialize
{
    _emotions = [NSKeyedUnarchiver unarchiveObjectWithFile:JSSEmotionsPath];
    if (_emotions == nil) {
        _emotions = [NSMutableArray array];
    }
}

/**
 *  添加表情
 */
+ (void)addEmotion:(JSSEmotion *)emotion
{
    // 判断表情是否重复
    if ([_emotions containsObject:emotion]) {
        [_emotions removeObject:emotion];
    }
    
    // 添加表情
    [_emotions insertObject:emotion atIndex:0];
    
    // 归档
    [NSKeyedArchiver archiveRootObject:_emotions toFile:JSSEmotionsPath];
}

/**
 *  获得表情
 */
+ (NSArray *)emotions
{
    return _emotions;
}

static NSArray *_defaultEmotions;
static NSArray *_emojiEmotions;
static NSArray *_flowerEmotions;

/**
 *  默认表情数组
 */
+ (NSArray *)defaultEmotions
{
    if (_defaultEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info" ofType:@"plist"];
        _defaultEmotions= [JSSEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    
    return _defaultEmotions;
}

/**
 *  emoji表情数组
 */
+ (NSArray *)emojiEmotions
{
    if (_emojiEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info" ofType:@"plist"];
        _emojiEmotions= [JSSEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    
    return _emojiEmotions;
}

/**
 *  浪小花表情数组
 */
+ (NSArray *)flowerEmotions
{
    if (_flowerEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info" ofType:@"plist"];
        _flowerEmotions= [JSSEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    
    return _flowerEmotions;
}

/**
 *  获取表情模型
 */
+ (JSSEmotion *)emotionWithText:(NSString *)text
{
    for (JSSEmotion *emotion in [self defaultEmotions]) {
        if ([emotion.chs isEqualToString:text]) {
            return emotion;
        }
    }
    
    for (JSSEmotion *emotion in [self flowerEmotions]) {
        if ([emotion.chs isEqualToString:text]) {
            return emotion;
        }
    }
    
    return nil;
}

@end
