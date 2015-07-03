//
//  JSSEmotionTextView.h
//  高仿微博
//
//  Created by JiShangsong on 15/7/3.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSTextView.h"
@class JSSEmotion;

@interface JSSEmotionTextView : JSSTextView

/**
 *  表情模型
 */
@property (nonatomic, strong) JSSEmotion *emotion;

@end
