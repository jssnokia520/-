//
//  JSSStatusPhotosView.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/22.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSStatusPhotosView.h"
#import "JSSPhoto.h"
#import "UIImageView+WebCache.h"

#define JSSPhotoWH 80
#define JSSMargin 10
#define JSSMaxRows(count) ((count == 4) ? 2 : 3)

@implementation JSSStatusPhotosView

/**
 *  拦截设置图片数组的方法
 */
- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    while (self.subviews.count < photos.count) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
    }
    
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        if (i < photos.count) {
            [imageView setHidden:NO];
            JSSPhoto *photo = photos[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        } else {
            [imageView setHidden:YES];
        }
    }
}

/**
 *  重新布局子控件位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger maxRows = JSSMaxRows(self.subviews.count);
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        
        NSInteger col = i / maxRows;
        NSInteger row = i % maxRows;
        
        CGFloat imageViewX = (JSSPhotoWH + JSSMargin) * row + JSSMargin;
        CGFloat imageViewY = (JSSPhotoWH + JSSMargin) * col + JSSMargin;
        
        [imageView setFrame:CGRectMake(imageViewX, imageViewY, JSSPhotoWH, JSSPhotoWH)];
    }
}

/**
 *  根据图片的数量获取视图的大小
 */
+ (CGSize)sizeWithCount:(NSInteger)count
{
    CGFloat width = (JSSPhotoWH + JSSMargin) * JSSMaxRows(count) + JSSMargin;
    CGFloat height = (JSSPhotoWH + JSSMargin) * ((count + JSSMaxRows(count) - 1) / JSSMaxRows(count)) + JSSMargin;
    
    return CGSizeMake(width, height);
}

@end
