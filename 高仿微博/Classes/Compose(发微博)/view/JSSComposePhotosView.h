//
//  JSSComposePhotosView.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/27.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSSComposePhotosView : UIView

/**
 *  添加图片
 */
- (void)addImage:(UIImage *)image;

/**
 *  获取图片视图中的图片
 */
- (NSArray *)images;

@end
