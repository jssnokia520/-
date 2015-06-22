//
//  NSString+Extension.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/22.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/**
 *  根据字体生成控件大小
 */
- (CGSize)textSizeWithFont:(UIFont *)font
{
    return [self textSizeWithFont:font textWidth:MAXFLOAT];
}

/**
 *  根据字体,宽度生成控件大小
 */
- (CGSize)textSizeWithFont:(UIFont *)font textWidth:(CGFloat)width
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    
    CGSize size = CGSizeMake(width, MAXFLOAT);
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

@end
