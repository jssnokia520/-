//
//  JSSEmotionTabBarView.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/29.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSEmotionTabBarView;

typedef enum {
    emotionTabBarViewButtonLatest,
    emotionTabBarViewButtonDefault,
    emotionTabBarViewButtonEmoji,
    emotionTabBarViewButtonFlower
} emotionTabBarViewButtonType;

@protocol JSSEmotionTabBarViewDelegate <NSObject>

- (void)emotionTabBarView:(JSSEmotionTabBarView *)emotionTabBarView emotionTabBarViewButtonType:(emotionTabBarViewButtonType)emotionTabBarViewButtonType;

@end

@interface JSSEmotionTabBarView : UIView

@property (nonatomic, weak) id<JSSEmotionTabBarViewDelegate> delegate;

@end
