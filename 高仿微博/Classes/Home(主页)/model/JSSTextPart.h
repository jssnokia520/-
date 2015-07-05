//
//  JSSTextPart.h
//  高仿微博
//
//  Created by JiShangsong on 15/7/5.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSTextPart : NSObject

/**
 *  片段文字
 */
@property (nonatomic, copy) NSString *text;

/**
 *  片段范围
 */
@property (nonatomic, assign) NSRange range;

/**
 *  是否是特殊片段
 */
@property (nonatomic, assign, getter = isSpecial) BOOL special;

/**
 *  是否是表情
 */
@property (nonatomic, assign, getter = isEmotion) BOOL emotion;

@end
