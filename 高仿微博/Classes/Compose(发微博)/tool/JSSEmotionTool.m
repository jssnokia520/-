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

/**
 *  添加表情
 */
+ (void)addEmotion:(JSSEmotion *)emotion
{
    NSMutableArray *emotions;
    
    if ([self emotions]) { // 获得表情
        emotions = [NSMutableArray arrayWithArray:[self emotions]];
    } else {
        emotions = [NSMutableArray array];
    }
    
    [emotions insertObject:emotion atIndex:0];
    
    // 归档
    [NSKeyedArchiver archiveRootObject:emotions toFile:JSSEmotionsPath];
}

/**
 *  获得表情
 */
+ (NSArray *)emotions
{
    // 解档
    return [NSKeyedUnarchiver unarchiveObjectWithFile:JSSEmotionsPath];
}

@end
