//
//  JSSStatusTextView.m
//  高仿微博
//
//  Created by JiShangsong on 15/7/5.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSStatusTextView.h"
#import "JSSSpecial.h"
#define JSSSpecialTag 999

@implementation JSSStatusTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setScrollEnabled:NO];
        [self setTextContainerInset:UIEdgeInsetsMake(0, -5, 0, -5)];
        [self setEditable:NO];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 获取触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:nil];
    
    // 遍历数组
    for (JSSSpecial *special in specials) {
        [self setSelectedRange:special.range];
        // 换行的时候
        NSArray *selectionRects = [self selectionRectsForRange:self.selectedTextRange];
        [self setSelectedRange:NSMakeRange(0, 0)];
        
        BOOL contains = NO;
        for (UITextSelectionRect *selectionRect in selectionRects) {
            if (selectionRect.rect.size.width != 0 && selectionRect.rect.size.height != 0 && CGRectContainsPoint(selectionRect.rect, point)) {
                contains = YES;
            }
        }
        
        if (contains) {
            for (UITextSelectionRect *selectionRect in selectionRects) {
                if (selectionRect.rect.size.width != 0 && selectionRect.rect.size.height != 0) {                    
                    UIView *cover = [[UIView alloc] init];
                    [cover setBackgroundColor:[UIColor orangeColor]];
                    [cover setFrame:selectionRect.rect];
                    [cover.layer setCornerRadius:5];
                    [self insertSubview:cover atIndex:0];
                    [cover setTag:JSSSpecialTag];
                }
            }
        }
    }
}

/**
 *  触摸结束,移除触摸背景
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIView *child in self.subviews) {
            if (child.tag == JSSSpecialTag) {
                [child removeFromSuperview];
            }
        }
    });
}

/**
 *  触摸被打断的时候,移除触摸背景
 */
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

@end
