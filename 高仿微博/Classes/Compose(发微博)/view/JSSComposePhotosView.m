//
//  JSSComposePhotosView.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/27.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSComposePhotosView.h"

@implementation JSSComposePhotosView

/**
 *  添加图片
 */
- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:image];
    
    [self addSubview:imageView];
}

/**
 *  重新布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    NSInteger maxCount = 3;
    CGFloat imageWH = 76;
    CGFloat margin = 10;
    
    for (NSInteger i = 0; i < count; i++) {
        UIImageView *imageView = self.subviews[i];
        
        NSInteger col = i % maxCount;
        NSInteger row = i / maxCount;
        
        CGFloat x = (margin + imageWH) * col + margin;
        CGFloat y = (margin + imageWH) * row + margin;

        [imageView setFrame:CGRectMake(x, y, imageWH, imageWH)];
    }
}

@end
