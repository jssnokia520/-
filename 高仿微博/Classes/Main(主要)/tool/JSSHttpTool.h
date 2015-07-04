//
//  JSSHttpTool.h
//  高仿微博
//
//  Created by JiShangsong on 15/7/5.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSHttpTool : NSObject

/**
 *  GET请求
 */
+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  POST请求
 */
+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
