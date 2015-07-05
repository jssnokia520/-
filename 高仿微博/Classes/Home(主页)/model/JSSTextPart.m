//
//  JSSTextPart.m
//  高仿微博
//
//  Created by JiShangsong on 15/7/5.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSTextPart.h"

@implementation JSSTextPart

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@-%@", NSStringFromRange(self.range), self.text];
}

@end
