//
//  JSSToolbar.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/21.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSStatus;

@interface JSSToolbar : UIView

+ (instancetype)toolbar;

@property (nonatomic, strong) JSSStatus *status;

@end
