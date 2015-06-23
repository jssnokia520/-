//
//  JSSUser.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/15.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    JSSVerifiedTypeNone = -1,
    JSSVerifiedTypePersonal = 0,
    JSSVerifiedTypeEnterprice = 2,
    JSSVerifiedTypeMedia = 3,
    JSSVerifiedTypeWebsite = 5,
    JSSVerifiedTypeDaren = 220
} JSSVerifiedType;

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

/**
 *  是否会员
 */
@property (nonatomic, assign, getter = isVip) BOOL vip;

/**
 *  会员类型
 */
@property (nonatomic, assign) NSInteger mbtype;
/**
 *  会员等级
 */
@property (nonatomic, assign) NSInteger mbrank;

/**
 *  verified_type 认证类型
 */
@property (nonatomic, assign) JSSVerifiedType verified_type;

@end
