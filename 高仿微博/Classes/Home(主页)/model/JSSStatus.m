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

    if ([createDate isThisYear]) {
        if ([createDate isToday]) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute;
            
            NSDateComponents *createComponents = [calendar components:unit fromDate:createDate];
            NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
            
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
            
        } else if ([createDate isYesterday]) {
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

- (void)setSource:(NSString *)source
{
    if (source.length) {
        NSInteger location = [source rangeOfString:@">"].location + 1;
        NSInteger length = [source rangeOfString:@"</"].location - location;
        
        _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:NSMakeRange(location, length)]];
    }
}

@end
