//
//  NSString+Extension.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/22.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  根据字体生成控件大小
 */
- (CGSize)textSizeWithFont:(UIFont *)font;

/**
 *  根据字体,宽度生成控件大小
 */
- (CGSize)textSizeWithFont:(UIFont *)font textWidth:(CGFloat)width;

@end
