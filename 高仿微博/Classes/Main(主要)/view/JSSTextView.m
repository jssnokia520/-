//
//  JSSTextView.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/26.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSTextView.h"

@implementation JSSTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFont:[UIFont systemFontOfSize:15]];
        // 设置水平方向总是弹簧效果
        [self setAlwaysBounceVertical:YES];
        [JSSNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

/**
 *  监听TextView文字的改变
 */
- (void)textDidChange
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (self.hasText) {
        return;
    }
    
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = self.width - 2 * x;
    CGFloat h = self.height - 2 * y;
    CGRect placeHolderRect = CGRectMake(x, y, w, h);
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = self.font;
    attributes[NSForegroundColorAttributeName] = self.placeHolderColor ? self.placeHolderColor : [UIColor lightGrayColor];
    
    [self.placeHolder drawInRect:placeHolderRect withAttributes:attributes];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    
    [self setNeedsDisplay];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor

{
    _placeHolderColor = placeHolderColor;
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

@end
