//
//  JSSStatusTextView.m
//  高仿微博
//
//  Created by JiShangsong on 15/7/5.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSStatusTextView.h"

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

@end
