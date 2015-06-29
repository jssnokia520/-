//
//  JSSEmotion.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/29.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSEmotion : NSObject

/**
 *  中文昵称
 */
@property (nonatomic, copy) NSString *chs;

/**
 *  png图片名称
 */
@property (nonatomic, copy) NSString *png;

/**
 *  emoji表情代码
 */
@property (nonatomic, copy) NSString *code;

@end
