//
//  JSSKeyboardToolBar.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/26.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSKeyboardToolBar;

typedef enum {
    JSSKeyboardButtonCamera,    // 相机
    JSSKeyboardButtonPicture,   // 相册
    JSSKeyboardButtonMention,   // @
    JSSKeyboardButtonTrend,     // #
    JSSKeyboardButtonMotion     // 表情
} JSSKeyboardButtonType;

@protocol JSSKeyboardToolBarDelegate <NSObject>

@optional
- (void)keyboardToolBar:(JSSKeyboardToolBar *)toolBar didClickButton:(JSSKeyboardButtonType)buttonType;

@end

@interface JSSKeyboardToolBar : UIView

@property (nonatomic, weak) id<JSSKeyboardToolBarDelegate> delegate;

/**
 *  标记是否是表情键盘
 */
@property (nonatomic, assign) BOOL isEmotionKeyboard;

@end
