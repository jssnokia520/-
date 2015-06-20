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

@end
