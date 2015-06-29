//
//  JSSEmotionTabBarButton.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/29.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSEmotionTabBarButton.h"

@implementation JSSEmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
