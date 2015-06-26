//
//  JSSTextView.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/26.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSSTextView : UITextView

/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placeHolder;

/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeHolderColor;

@end
