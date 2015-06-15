//
//  JSSStatus.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/15.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSStatus.h"
#import "JSSUser.h"

@implementation JSSStatus

+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    JSSStatus *status = [[self alloc] init];
    
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    status.user = [JSSUser userWithDict:dict[@"user"]];
    
    return status;
}

@end
