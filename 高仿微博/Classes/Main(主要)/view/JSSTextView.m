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
        [JSSNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

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
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    attributes[NSForegroundColorAttributeName] = self.placeHolderColor;
    
    [self.placeHolder drawInRect:placeHolderRect withAttributes:attributes];
}

@end
