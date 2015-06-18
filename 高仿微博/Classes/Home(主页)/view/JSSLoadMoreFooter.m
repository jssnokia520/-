//
//  JSSLoadMoreFooter.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/18.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSLoadMoreFooter.h"

@implementation JSSLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JSSLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
