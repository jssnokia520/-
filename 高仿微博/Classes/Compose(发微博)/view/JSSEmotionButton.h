//
//  JSSEmotionButton.h
//  高仿微博
//
//  Created by JiShangsong on 15/7/1.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSEmotion;

@interface JSSEmotionButton : UIButton

/**
 *  表情模型
 */
@property (nonatomic, strong) JSSEmotion *emotion;

@end
