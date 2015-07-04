//
//  JSSEmotionTool.m
//  高仿微博
//
//  Created by JiShangsong on 15/7/4.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSEmotionTool.h"
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

@end
