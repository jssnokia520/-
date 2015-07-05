//
//  JSSStatus.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/15.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSSUser;

@interface JSSStatus : NSObject

/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  带有属性的微博信息内容
 */
@property (nonatomic, copy) NSAttributedString *attributedText;

/**
 *  微博作者的用户信息字段
 */
@property (nonatomic, strong) JSSUser *user;

/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *pic_urls;

/**
 *  转发的微博
 */
@property (nonatomic, strong) JSSStatus *retweeted_status;

/**
 *  带有属性的转发微博消息
 */
@property (nonatomic, copy) NSAttributedString *retweetedAttributedText;

/**
 *  转发数
 */
@property (nonatomic, assign) NSInteger reposts_count;

/**
 *  评论数
 */
@property (nonatomic, assign) NSInteger comments_count;

/**
 *  表态数
 */
@property (nonatomic, assign) NSInteger attitudes_count;

@end
