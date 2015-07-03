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
        // 获取图片
        UIImage *image = [UIImage imageNamed:emotion.png];
        
        // 文本附件
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        
        // 设置附件的尺寸
        [textAttachment setBounds:CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight)];
        
        // 设置文本附件的图片
        [textAttachment setImage:image];
        
        // 使用文本附件来创建一个带有属性的字符串
        NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        
        // 插入附件
        [self insertAttributeText:attributedString settingBlock:^(NSMutableAttributedString *attributedText) {
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
    }
}

@end
