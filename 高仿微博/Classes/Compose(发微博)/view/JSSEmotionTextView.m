//
//  JSSEmotionTextView.m
//  高仿微博
//
//  Created by JiShangsong on 15/7/3.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSEmotionTextView.h"
#import "JSSEmotion.h"
#import "NSString+Emoji.h"
#import "UITextView+Extension.h"
#import "JSSTextAttachment.h"

@implementation JSSEmotionTextView

/**
 *  拦截表情模型
 */
- (void)setEmotion:(JSSEmotion *)emotion
{
    if (emotion.code) { // emoji表情
        NSString *emojiStr = [NSString emojiWithStringCode:emotion.code];
        [self insertText:emojiStr];
    } else { // 图片表情
        JSSTextAttachment *attachment = [[JSSTextAttachment alloc] init];
        [attachment setEmotion:emotion];
        
        // 设置附件的尺寸
        [attachment setBounds:CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight)];
        
        // 设置文本附件的图片
        [attachment setImage:attachment.image];
        
        // 使用文本附件来创建一个带有属性的字符串
        NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        // 插入附件
        [self insertAttributeText:attributedString settingBlock:^(NSMutableAttributedString *attributedText) {
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
    }
}

/**
 *  转换发送文本
 */
- (NSString *)sendText
{
    NSMutableString *strM = [NSMutableString string];
    
    NSAttributedString *attributedText = self.attributedText;
    [attributedText enumerateAttributesInRange:NSMakeRange(0, attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        JSSTextAttachment *attachment = attrs[@"NSAttachment"];
        if (attachment) { // 有图片表情
            [strM appendString:attachment.emotion.chs];
        } else { // 没有图片表情
            NSString *str = [[attributedText attributedSubstringFromRange:range] string];
            [strM appendString:str];
        }
    }];
    
    return strM;
}

@end
