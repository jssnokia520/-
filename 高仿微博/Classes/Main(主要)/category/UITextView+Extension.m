//
//  UITextView+Extension.m
//  高仿微博
//
//  Created by JiShangsong on 15/7/3.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

- (void)insertAttributeText:(NSAttributedString *)attributedString {
    [self insertAttributeText:attributedString settingBlock:nil];
}

- (void)insertAttributeText:(NSAttributedString *)attributedString settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    // 初始化一个可变的带有属性的字符串
    NSMutableAttributedString *attributedStringM = [[NSMutableAttributedString alloc] init];
    
    // 将文本框中属性字符串取出放到可变属性字符串中
    [attributedStringM setAttributedString:self.attributedText];
    
    // 获取光标位置
    NSRange selectedRange = self.selectedRange;
    
    // 用附件属性字符串代替被选中的字符串
    [attributedStringM replaceCharactersInRange:self.selectedRange withAttributedString:attributedString];
    
    if (settingBlock) {
        settingBlock(attributedStringM);
    }
    
    // 设置文本框内容
    [self setAttributedText:attributedStringM];
    
    // 重新设置光标位置
    [self setSelectedRange:NSMakeRange(selectedRange.location + 1, 0)];
}

@end
