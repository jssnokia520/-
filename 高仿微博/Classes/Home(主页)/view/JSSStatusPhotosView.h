//
//  JSSStatusPhotosView.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/22.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSSStatusPhotosView : UIView

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片的数量获取视图的大小
 */
+ (CGSize)sizeWithCount:(NSInteger)count;

@end
