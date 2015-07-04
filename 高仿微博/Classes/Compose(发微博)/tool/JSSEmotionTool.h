//
//  JSSEmotionTool.h
//  高仿微博
//
//  Created by JiShangsong on 15/7/4.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSSEmotion;

@interface JSSEmotionTool : NSObject

/**
 *  添加表情
 */
+ (void)addEmotion:(JSSEmotion *)emotion;

/**
 *  获得表情
 */
+ (NSArray *)emotions;

@end
