//
//  JSSUser.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/15.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSUser.h"

@implementation JSSUser

+ (instancetype)userWithDict:(NSDictionary *)dict
{
    JSSUser *user = [[self alloc] init];
    
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    
    return user;
}

@end
