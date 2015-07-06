//
//  JSSSpecial.h
//  高仿微博
//
//  Created by JiShangsong on 15/7/6.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSSpecial : NSObject

/**
 *  特殊片段文字
 */
@property (nonatomic, copy) NSString *text;

/**
 *  特殊片段文字范围
 */
@property (nonatomic, assign) NSRange range;

@end
