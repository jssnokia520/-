//
//  JSSUser.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/15.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSUser : NSObject

/**
 *  字符串型的用户UID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  友好显示名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  用户头像地址（中图），50×50像素
 */
@property (nonatomic, copy) NSString *profile_image_url;

@end
