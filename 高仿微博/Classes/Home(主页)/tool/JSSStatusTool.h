//
//  JSSStatusTool.h
//  高仿微博
//
//  Created by JiShangsong on 15/7/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSStatusTool : NSObject

/**
 *  存储缓存数据
 */
+ (void)saveStatusData:(NSArray *)statuses;

/**
 *  获取缓存数据
 */
+ (NSArray *)statusWithParameters:(NSDictionary *)parameters;

@end
