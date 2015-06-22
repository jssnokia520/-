//
//  JSSStatusPhotoView.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/22.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "JSSPhoto.h"

@interface JSSStatusPhotoView ()

@property (nonatomic, weak) UIImageView *gifImageView;

@end

@implementation JSSStatusPhotoView

- (UIImageView *)gifImageView
{
    if (_gifImageView == nil) {
        UIImageView *gifImageView = [[UIImageView alloc] init];
        UIImage *gifImage = [UIImage imageNamed:@"timeline_image_gif"];
        gifImageView.size = gifImage.size;
        [gifImageView setImage:gifImage];
        [self addSubview:gifImageView];
        _gifImageView = gifImageView;
    }
    
    return _gifImageView;
}

- (void)setPhoto:(JSSPhoto *)photo
{
    _photo = photo;
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    [self.gifImageView setHidden:![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.gifImageView setX:self.width - self.gifImageView.width];
    [self.gifImageView setY:self.height - self.gifImageView.height];
}

@end
