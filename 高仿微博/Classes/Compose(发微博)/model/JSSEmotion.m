//
//  JSSEmotion.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/29.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSEmotion.h"

@implementation JSSEmotion

/**
 *  解档
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
    }
    
    return self;
}

/**
 *  归档
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
}

/**
 *  拦截对象判断方法
 */
- (BOOL)isEqual:(JSSEmotion *)emotion
{
    return [self.chs isEqualToString:emotion.chs] || [self.code isEqualToString:emotion.code];
}

@end
