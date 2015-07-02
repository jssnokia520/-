//
//  JSSEmotionPopView.h
//  高仿微博
//
//  Created by JiShangsong on 15/7/1.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSEmotion;

@interface JSSEmotionPopView : UIView

@property (nonatomic, strong) JSSEmotion *emotion;

/**
 *  快速创建弹出视图
 */
+ (instancetype)popView;

@end
