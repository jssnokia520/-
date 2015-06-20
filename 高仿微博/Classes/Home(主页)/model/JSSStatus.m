//
//  JSSStatus.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/15.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSStatus.h"
#import "MJExtension.h"
#import "JSSPhoto.h"

@implementation JSSStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [JSSPhoto class]};
}

@end
