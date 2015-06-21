//
//  JSSToolbar.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/21.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSToolbar.h"
#import "JSSStatus.h"

@interface JSSToolbar ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *separators;

@property (nonatomic, weak) UIButton *repostsButton;
@property (nonatomic, weak) UIButton *commentsButton;
@property (nonatomic, weak) UIButton *attitudesButton;

@end

@implementation JSSToolbar

+ (instancetype)toolbar
{
    return [[self alloc] init];
}

- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray *)separators
{
    if (_separators == nil) {
        _separators = [NSMutableArray array];
    }
    return _separators;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]]];
        
        self.repostsButton = [self addButton:@"timeline_icon_retweet" title:@"转发"];
        self.commentsButton = [self addButton:@"timeline_icon_comment" title:@"评论"];
        self.attitudesButton = [self addButton:@"timeline_icon_unlike" title:@"赞"];
        
        [self addSeparator];
        [self addSeparator];
    }
    return self;
}

/**
 *  添加分割线
 */
- (void)addSeparator
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
    [self addSubview:imageView];
    [self.separators addObject:imageView];
}

/**
 *  添加按钮
 *
 *  @param image 按钮图片名称
 *  @param title 按钮标题名称
 */
- (UIButton *)addButton:(NSString *)image title:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self addSubview:button];
    [self.buttons addObject:button];
    return button;
}

/**
 *  重新布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的位置
    CGFloat buttonW = self.width / self.buttons.count;
    for (NSInteger i = 0; i < self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        button.x = buttonW * i;
        button.y = 0;
        button.width = buttonW;
        button.height = self.height;
    }
    
    // 设置分割线位置
    for (NSInteger i = 0; i < self.separators.count; i++) {
        UIImageView *imageView = self.separators[i];
        imageView.x = (i + 1) * buttonW;
        imageView.y = 0;
        imageView.width = 1;
        imageView.height = self.height;
    }
}

- (void)setStatus:(JSSStatus *)status
{
    _status = status;
    
    [self setupButton:self.repostsButton count:status.reposts_count title:@"转发"];
    [self setupButton:self.commentsButton count:status.comments_count title:@"评论"];
    [self setupButton:self.attitudesButton count:status.attitudes_count title:@"赞"];
}

- (void)setupButton:(UIButton *)button count:(NSInteger)count  title:(NSString *)title
{
    if (count) {
        if (count > 9999) {
            NSString *countString = [NSString stringWithFormat:@"%.1f", count / 10000.0];
            NSString *wanString = [countString stringByReplacingOccurrencesOfString:@".0" withString:@""];
            [button setTitle:[NSString stringWithFormat:@"%@万", wanString] forState:UIControlStateNormal];
        } else {
            [button setTitle:[NSString stringWithFormat:@"%ld", count] forState:UIControlStateNormal];
        }
    } else {
        [button setTitle:title forState:UIControlStateNormal];
    }
}

@end
