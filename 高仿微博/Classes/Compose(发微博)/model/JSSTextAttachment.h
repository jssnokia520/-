//
//  JSSTextAttachment.h
//  高仿微博
//
//  Created by JiShangsong on 15/7/3.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSEmotion;

@interface JSSTextAttachment : NSTextAttachment

/**
 *  表情模型
 */
@property (nonatomic, strong) JSSEmotion *emotion;

@end
