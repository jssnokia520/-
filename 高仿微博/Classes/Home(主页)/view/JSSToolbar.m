//
//  JSSToolbar.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/21.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSToolbar.h"

@implementation JSSToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addButton:@"timeline_icon_retweet" title:@"转发"];
        [self addButton:@"timeline_icon_comment" title:@"评论"];
        [self addButton:@"timeline_icon_unlike" title:@"赞"];
    }
    return self;
}

- (void)addButton:(NSString *)image title:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self addSubview:button];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.width / self.subviews.count;
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        button.x = buttonW * i;
        button.y = 0;
        button.width = buttonW;
        button.height = self.height;
    }
}

@end
