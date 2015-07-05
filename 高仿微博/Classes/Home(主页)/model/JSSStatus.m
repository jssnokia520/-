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
#import "JSSTextPart.h"
#import "JSSEmotion.h"
#import "JSSEmotionTool.h"

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
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    NSMutableArray *parts = [NSMutableArray array];

    // 遍历特殊文字
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        JSSTextPart *part = [[JSSTextPart alloc] init];
        [part setText:*capturedStrings];
        [part setRange:*capturedRanges];
        [part setSpecial:YES];
        NSString *capturedString = *capturedStrings;
        [part setEmotion:[capturedString hasPrefix:@"["] && [capturedString hasSuffix:@"]"]];
        
        [parts addObject:part];
    }];
    
    // 遍历非特殊文字
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        JSSTextPart *part = [[JSSTextPart alloc] init];
        [part setText:*capturedStrings];
        [part setRange:*capturedRanges];
        [part setSpecial:NO];
        
        [parts addObject:part];
    }];
    
    [parts sortedArrayUsingComparator:^NSComparisonResult(JSSTextPart *part1, JSSTextPart *part2) {
        if (part1.range.location > part2.range.location) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];

    UIFont *font = [UIFont systemFontOfSize:15];
    NSAttributedString *attributed;
    for (JSSTextPart *part in parts) {
        if (part.isEmotion) { // 是表情字符串
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
            JSSEmotion *emotion = [JSSEmotionTool emotionWithText:part.text];
            if (emotion) {
                [attachment setImage:[UIImage imageNamed:emotion.png]];
                [attachment setBounds:CGRectMake(0, -3, font.lineHeight, font.lineHeight)];
                attributed = [NSAttributedString attributedStringWithAttachment:attachment];
            } else {
                attributed = [[NSAttributedString alloc] initWithString:part.text];
            }
        } else if (part.isSpecial) { // 特殊字符串
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:part.text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, attributedString.length)];
            attributed = attributedString;
        } else { // 非特殊字符串
            attributed = [[NSAttributedString alloc] initWithString:part.text];
        }
        
        [attributedText appendAttributedString:attributed];
    }
    
    // 统一字体
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    
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
