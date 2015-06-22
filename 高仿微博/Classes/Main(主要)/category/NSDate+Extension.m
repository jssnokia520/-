//
//  NSDate+Extension.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/22.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  判断是否是今年
 */
- (BOOL)isThisYear
{
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    
    NSDateComponents *create = [calendar components:unit fromDate:self];
    NSDateComponents *now = [calendar components:unit fromDate:nowDate];
    
    if (create.year == now.year) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  是否是今天
 */
- (BOOL)isToday
{
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *createComponents = [calendar components:unit fromDate:self];
    NSDateComponents *nowComponents = [calendar components:unit fromDate:nowDate];
    
    NSInteger deltaMonth = createComponents.month - nowComponents.month;
    NSInteger deltaDay = createComponents.day - nowComponents.day;
    
    if (deltaMonth == 0 && deltaDay == 0) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  是否是昨天
 */
- (BOOL)isYesterday
{
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *createComponents = [calendar components:unit fromDate:self];
    NSDateComponents *nowComponents = [calendar components:unit fromDate:nowDate];
    
    NSInteger deltaMonth = createComponents.month = nowComponents.month;
    NSInteger deltaDay = createComponents.day - nowComponents.day;
    
    if (deltaMonth == 0 && deltaDay == 1) {
        return YES;
    } else {
        return NO;
    }
}

@end
