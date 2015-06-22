//
//  JSSStatusFrame.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/20.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSSStatus;

#define JSSStatusCellMargin 10
#define JSSNameFont [UIFont systemFontOfSize:15]
#define JSSTimeFont [UIFont systemFontOfSize:13]
#define JSSSourceFont [UIFont systemFontOfSize:13]
#define JSSContentFont [UIFont systemFontOfSize:13]
#define JSSRetweetContentFont [UIFont systemFontOfSize:13]

@interface JSSStatusFrame : NSObject

/**
 *  微博模型
 */
@property (nonatomic, strong) JSSStatus *status;

/**
 *  原创微博视图
 */
@property (nonatomic, assign) CGRect originalFrame;

/**
 *  头像
 */
@property (nonatomic, assign) CGRect iconFrame;

/**
 *  昵称
 */
@property (nonatomic, assign) CGRect nameFrame;

/**
 *  VIP
 */
@property (nonatomic, assign) CGRect vipFrame;

/**
 *  时间
 */
@property (nonatomic, assign) CGRect timeFrame;

/**
 *  来源
 */
@property (nonatomic, assign) CGRect sourceFrame;

/**
 *  正文
 */
@property (nonatomic, assign) CGRect contentFrame;

/**
 *  图片视图
 */
@property (nonatomic, assign) CGRect photosFrame;

/**
 *  高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 *  转发微博视图
 */
@property (nonatomic, assign) CGRect retweetViewFrame;

/**
 *  转发的微博正文 + 昵称
 */
@property (nonatomic, assign) CGRect retweetContentLabelFrame;

/**
 *  转发的微博图片视图
 */
@property (nonatomic, assign) CGRect retweetPhotosImageViewFrame;

/**
 *  工具条视图
 */
@property (nonatomic, assign) CGRect toolbarFrame;

@end
