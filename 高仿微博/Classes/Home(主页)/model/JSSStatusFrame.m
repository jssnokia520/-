//
//  JSSStatusFrame.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/20.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSStatusFrame.h"
#import "JSSStatus.h"
#import "JSSUser.h"

#define JSSStatusCellMargin 10


@implementation JSSStatusFrame

/**
 *  根据文字生成控件大小
 */
- (CGSize)textSizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self textSizeWithText:text font:font textWidth:MAXFLOAT];
}

- (CGSize)textSizeWithText:(NSString *)text font:(UIFont *)font textWidth:(CGFloat)width
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    
    CGSize size = CGSizeMake(width, MAXFLOAT);
    return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

/**
 *  微博模型
 */
- (void)setStatus:(JSSStatus *)status
{
    _status = status;
    
    // 开始计算控件位置
    
    JSSUser *user = status.user;
    
    /**
     *  头像
     */
    CGFloat iconX = JSSStatusCellMargin;
    CGFloat iconY = JSSStatusCellMargin;
    CGFloat iconWH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /**
     *  昵称
     */
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + JSSStatusCellMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [self textSizeWithText:user.name font:JSSNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    /**
     *  VIP
     */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + JSSStatusCellMargin;
        CGFloat vipY = nameY;
        CGSize vipSize = CGSizeMake(self.nameFrame.size.height, self.nameFrame.size.height);
        self.vipFrame = (CGRect){{vipX, vipY}, vipSize};
    }
    
    /**
     *  时间
     */
    CGFloat timeX = CGRectGetMaxX(self.iconFrame) + JSSStatusCellMargin;
    CGFloat timeY = CGRectGetMaxY(self.nameFrame) + JSSStatusCellMargin;
    CGSize timeSize = [self textSizeWithText:status.created_at font:JSSTimeFont];
    self.timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    /**
     *  来源
     */
    CGFloat sourceX = CGRectGetMaxX(self.timeFrame) + JSSStatusCellMargin;
    CGFloat sourceY = CGRectGetMaxY(self.nameFrame) + JSSStatusCellMargin;
    CGSize sourceSize = [self textSizeWithText:status.source font:JSSSourceFont];
    self.sourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /**
     *  正文
     */
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconFrame), CGRectGetMaxY(self.timeFrame)) + JSSStatusCellMargin;
    CGFloat contentX = iconX;
    CGFloat width = screenWidth - contentX * 2;
    CGSize contentSize = [self textSizeWithText:status.text font:JSSContentFont textWidth:width];
    self.contentFrame = (CGRect){{contentX, contentY}, contentSize};
    
    /**
     *  图片
     */
    CGFloat originalHeight;
    if (status.pic_urls.count) { // 有图片
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentFrame) + JSSStatusCellMargin;
        CGFloat photoW = 100;
        CGFloat photoH = 120;
        self.photoFrame = CGRectMake(photoX, photoY, photoW, photoH);
        originalHeight = CGRectGetMaxY(self.photoFrame);
    } else { // 没有图片
        originalHeight = CGRectGetMaxY(self.contentFrame);
    }
    
    /**
     *  上半部分视图的父视图
     */
    self.originalFrame = CGRectMake(0, 0, screenWidth, originalHeight);
    
    /**
     *  高度
     */
    self.cellHeight = CGRectGetMaxY(self.originalFrame) + JSSStatusCellMargin;
}

@end
