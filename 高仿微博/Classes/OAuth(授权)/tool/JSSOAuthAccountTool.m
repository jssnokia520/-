//
//  JSSOAuthAccountTool.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/11.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSOAuthAccountTool.h"
#import "JSSOAuthAccount.h"

#define Path    [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"access_token.plist"]

@implementation JSSOAuthAccountTool

+ (void)saveAccount:(JSSOAuthAccount *)account
{
    // 存储保存用户信息时的时间
    [account setSaveTime:[NSDate date]];
    [NSKeyedArchiver archiveRootObject:account toFile:Path];
}

+ (JSSOAuthAccount *)account
{
    JSSOAuthAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:Path];
    
    // 保存用户信息时的时间
    NSDate *saveDate = account.saveTime;
    
    // 当前时间
    NSDate *currentDate = [NSDate date];
    
    // 计算过期时间
    NSDate *expiresDate = [saveDate dateByAddingTimeInterval:account.expires_in.longLongValue];
    
    // 判断是否已过期
    NSComparisonResult result = [expiresDate compare:currentDate];
    if (result != NSOrderedDescending) {
        return nil;
    }
    
    return account;
}

@end
