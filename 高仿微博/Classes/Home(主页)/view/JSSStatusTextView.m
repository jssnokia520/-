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

/**
 *  初始化所有特殊片段文字的矩形框
 */
- (void)setupRects
{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:nil];
    for (JSSSpecial *special in specials) {
        [self setSelectedRange:special.range];
        NSArray *selectionRects = [self selectionRectsForRange:self.selectedTextRange];
        [self setSelectedRange:NSMakeRange(0, 0)];
        
        NSMutableArray *rects = [NSMutableArray array];
        for (UITextSelectionRect *selectionRect in selectionRects) {
            if (selectionRect.rect.size.width != 0 && selectionRect.rect.size.height) {
                [rects addObject:[NSValue valueWithCGRect:selectionRect.rect]];
            }
        }
        special.rects = rects;
    }
}

/**
 *  根据触摸点来获取特殊文字对象
 */
- (JSSSpecial *)specialWithPoint:(CGPoint)point
{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:nil];
    for (JSSSpecial *special in specials) {
        for (NSValue *rectValue in special.rects) {
            if (CGRectContainsPoint(rectValue.CGRectValue, point)) {
                return special;
            }
        }
    }
    
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 获取触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    // 初始化所有特殊片段文字的矩形框
    [self setupRects];
    
    JSSSpecial *special = [self specialWithPoint:point];
    
    for (NSValue *rectValue in special.rects) {
        UIView *cover = [[UIView alloc] init];
            [cover setBackgroundColor:[UIColor orangeColor]];
            [cover setFrame:rectValue.CGRectValue];
            [cover.layer setCornerRadius:5];
            [self insertSubview:cover atIndex:0];
            [cover setTag:JSSSpecialTag];
    }
}

/**
 *  触摸结束,移除触摸背景
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}

/**
 *  触摸被打断的时候,移除触摸背景
 */
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *child in self.subviews) {
        if (child.tag == JSSSpecialTag) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  事件处理
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    [self setupRects];
    
    JSSSpecial *special = [self specialWithPoint:point];
    
    if (special) {
        return YES;
    } else {
        return NO;
    }
}

@end
