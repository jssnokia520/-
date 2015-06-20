//
//  JSSUser.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/15.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSUser.h"

@implementation JSSUser

- (void)setMbrank:(NSInteger )mbrank
{
    _mbrank = mbrank;
    
    self.vip = _mbrank > 2;
}

@end
