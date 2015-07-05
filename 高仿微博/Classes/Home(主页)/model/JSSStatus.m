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
#import "RegexKitLite.h"
#import "JSSUser.h"

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

/**
 *  微博信息内容
 */
- (void)setText:(NSString *)text
{
    _text = text;
    
    self.attributedText = [self attributedTextWithText:text];
}

/**
 *  根据text来返回attributedText
 */
- (NSAttributedString *)attributedTextWithText:(NSString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:*capturedRanges];
    }];
    
    return attributedText;
}

/**
 *  转发的微博
 */
- (void)setRetweeted_status:(JSSStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    NSString *str = [NSString stringWithFormat:@"@%@ : %@", retweeted_status.user.name, retweeted_status.text];
    self.retweetedAttributedText = [self attributedTextWithText:str];
}

@end
