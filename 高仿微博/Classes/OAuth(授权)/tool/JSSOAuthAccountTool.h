//
//  JSSOAuthAccountTool.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/11.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSSOAuthAccount;

@interface JSSOAuthAccountTool : NSObject

/**
 *  存储账号信息
 */
+ (void)saveAccount:(JSSOAuthAccount *)account;

/**
 *  获取账号信息
 */
+ (JSSOAuthAccount *)account;

@end
