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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSDate *createDate = [formatter dateFromString:_created_at];
    
    NSLog(@"%@", createDate);
    
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:calendarUnit fromDate:createDate toDate:nowDate options:0];
    NSLog(@"Year:%ld    Month:%ld   Day:%ld     Hour:%ld    Minute:%ld  Second:%ld", components.year, components.month, components.day, components.hour, components.minute, components.second);

    return createDate.description;
}

@end
