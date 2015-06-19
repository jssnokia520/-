//
//  JSSTitleButton.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/11.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSTitleButton.h"
#define JSSMargin 5

@implementation JSSTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

// 重写setFrame方法以调整控件位置
- (void)setFrame:(CGRect)frame
{
    frame.size.width += JSSMargin;
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel setX:self.imageView.x];
    [self.imageView setX:CGRectGetMaxX(self.titleLabel.frame) + JSSMargin];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    [self sizeToFit];
}

@end
