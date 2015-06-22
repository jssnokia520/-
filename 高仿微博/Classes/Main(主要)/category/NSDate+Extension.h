//
//  NSDate+Extension.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/22.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 *  判断是否是今年
 */
- (BOOL)isThisYear;

/**
 *  是否是今天
 */
- (BOOL)isToday;

/**
 *  是否是昨天
 */
- (BOOL)isYesterday;

@end
