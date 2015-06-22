//
//  JSSStatus.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/15.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSStatus.h"
#import "MJExtension.h"
#import "JSSPhoto.h"

@implementation JSSStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [JSSPhoto class]};
}

/**
 *  拦截微博创建时间
 */
- (NSString *)created_at
{
//    _created_at = @"Mon Jun 22 11:50:15 +0800 2014";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    
    NSDate *createDate = [formatter dateFromString:_created_at];
    NSDate *nowDate = [NSDate date];

    if ([self isThisYear:createDate andNowDate:nowDate]) {
        if ([self isToday:createDate andNowDate:nowDate]) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute;
            
            NSDateComponents *createComponents = [calendar components:unit fromDate:createDate];
            NSDateComponents *nowComponents = [calendar components:unit fromDate:nowDate];
            
            NSInteger deltaHour = nowComponents.hour - createComponents.hour;
            NSInteger deltaMinute = nowComponents.minute - createComponents.minute;
            
            if (deltaHour == 0 && deltaMinute < 1) {
                return @"刚刚";
            } else if (deltaHour == 0 && deltaMinute < 60) {
                return [NSString stringWithFormat:@"%ld分钟前", deltaMinute];
            } else if (deltaHour > 0 && deltaHour < 4) {
                return [NSString stringWithFormat:@"%ld小时前", deltaHour];
            } else {
                [formatter setDateFormat:@"今天 HH:mm"];
                return [formatter stringFromDate:createDate];
            }
            
        } else if ([self isYesterday:createDate andNowDate:nowDate]) {
            [formatter setDateFormat:@"昨天 HH:mm"];
            return [formatter stringFromDate:createDate];
        } else {
            [formatter setDateFormat:@"MM-dd HH:mm"];
            return [formatter stringFromDate:createDate];
        }
    } else {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [formatter stringFromDate:createDate];
    }
}

/**
 *  判断是否是今年
 */
- (BOOL)isThisYear:(NSDate *)createDate andNowDate:(NSDate *)nowDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    
    NSDateComponents *create = [calendar components:unit fromDate:createDate];
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
- (BOOL)isToday:(NSDate *)createDate andNowDate:(NSDate *)nowDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *createComponents = [calendar components:unit fromDate:createDate];
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
- (BOOL)isYesterday:(NSDate *)createDate andNowDate:(NSDate *)nowDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *createComponents = [calendar components:unit fromDate:createDate];
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
