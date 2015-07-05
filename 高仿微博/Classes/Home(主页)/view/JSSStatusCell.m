//
//  JSSStatusCell.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/19.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSStatusCell.h"
#import "JSSStatusFrame.h"
#import "JSSStatus.h"
#import "JSSUser.h"
#import "UIImageView+WebCache.h"
#import "JSSPhoto.h"
#import "JSSToolbar.h"
#import "JSSStatusPhotosView.h"
#import "JSSIconImageView.h"
#import "JSSStatusTextView.h"

@interface JSSStatusCell ()

/**
 *  原创微博视图
 */
@property (nonatomic, weak) UIView *originalView;

/**
 *  头像
 */
@property (nonatomic, weak) JSSIconImageView *iconImageView;

/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;

/**
 *  VIP
 */
@property (nonatomic, weak) UIImageView *vipImageView;

/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;

/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;

/**
 *  正文
 */
@property (nonatomic, weak) JSSStatusTextView *contentLabel;

/**
 *  图片视图
 */
@property (nonatomic, weak) JSSStatusPhotosView *photosImageView;

/**
 *  转发微博视图
 */
@property (nonatomic, weak) UIView *retweetView;

/**
 *  转发的微博正文 + 昵称
 */
@property (nonatomic, weak) JSSStatusTextView *retweetContentLabel;

/**
 *  转发的微博图片视图
 */
@property (nonatomic, weak) JSSStatusPhotosView *retweetPhotosImageView;

/**
 *  工具条视图
 */
@property (nonatomic, weak) JSSToolbar *toolbar;

@end

@implementation JSSStatusCell

/**
 *  快速创建UITableViewCell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    JSSStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

/**
 *  初始化自定义UITableViewCell
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 取消选中样式
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // 清空Cell北京颜色
        [self setBackgroundColor:[UIColor clearColor]];
        
        // 原创微博视图
        [self setupOriginal];
        
        // 转发微博视图
        [self setupRetweet];
        
        // 工具条视图
        [self setupToolbar];
    }
    return self;
}

/**
 *  工具条视图
 */
- (void)setupToolbar
{
    JSSToolbar *toolbar = [JSSToolbar toolbar];
    [self addSubview:toolbar];
    self.toolbar = toolbar;
}

/**
 *  转发微博视图
 */
- (void)setupRetweet
{
    UIView *retweetView = [[UIView alloc] init];
    [retweetView setBackgroundColor:JSSColor(241, 241, 241)];
    [self.originalView addSubview:retweetView];
    self.retweetView = retweetView;
    
    
    JSSStatusTextView *retweetContentLabel = [[JSSStatusTextView alloc] init];
    [retweetContentLabel setFont:JSSRetweetContentFont];
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    JSSStatusPhotosView *retweetPhotosView = [[JSSStatusPhotosView alloc] init];
    self.retweetPhotosImageView = retweetPhotosView;
    [self.retweetView addSubview:retweetPhotosView];
}

/**
 *  原创微博视图
 */
- (void)setupOriginal
{
    UIView *originalView = [[UIView alloc] init];
    [originalView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    JSSIconImageView *iconImageView = [[JSSIconImageView alloc] init];
    [originalView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UIImageView *vipImageView = [[UIImageView alloc] init];
    [vipImageView setContentMode:UIViewContentModeCenter];
    [originalView addSubview:vipImageView];
    self.vipImageView = vipImageView;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [[UILabel alloc] init];
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    JSSStatusTextView *contentLabel = [[JSSStatusTextView alloc] init];
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    JSSStatusPhotosView *photosView = [[JSSStatusPhotosView alloc] init];
    [originalView addSubview:photosView];
    self.photosImageView = photosView;
}

/**
 *  微博Frame模型
 */
- (void)setStatusFrame:(JSSStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    JSSStatus *status = statusFrame.status;
    JSSUser *user = status.user;
    
    [self.originalView setFrame:statusFrame.originalFrame];
    
    [self.iconImageView setFrame:statusFrame.iconFrame];
    self.iconImageView.user = user;
    
    [self.nameLabel setFrame:statusFrame.nameFrame];
    [self.nameLabel setFont:JSSNameFont];
    [self.nameLabel setText:user.name];
    
    [self.vipImageView setFrame:statusFrame.vipFrame];
    if (user.isVip) {
        [self.vipImageView setHidden:NO];
        [self.nameLabel setTextColor:[UIColor orangeColor]];
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%ld", user.mbrank];
        [self.vipImageView setImage:[UIImage imageNamed:vipName]];
    } else {
        [self.vipImageView setHidden:YES];
        [self.nameLabel setTextColor:[UIColor blackColor]];
    }
    
    [self.timeLabel setFrame:statusFrame.timeFrame];
    [self.timeLabel setFont:JSSTimeFont];
    [self.timeLabel setText:status.created_at];
    
    // 重新计算时间标签
    CGSize timeSize = [status.created_at textSizeWithFont:JSSTimeFont];
    self.timeLabel.size = timeSize;
    
    [self.sourceLabel setFrame:statusFrame.sourceFrame];
    [self.sourceLabel setFont:JSSSourceFont];
    [self.sourceLabel setText:status.source];
    
    // 重新计算来源标签
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame);
    self.sourceLabel.x = sourceX + JSSStatusCellMargin;
    
    [self.contentLabel setFrame:statusFrame.contentFrame];
    [self.contentLabel setFont:JSSContentFont];
    [self.contentLabel setAttributedText:status.attributedText];
    
    if (status.pic_urls.count) {
        [self.photosImageView setHidden:NO];
        self.photosImageView.photos = status.pic_urls;
        [self.photosImageView setFrame:statusFrame.photosFrame];
    } else {
        [self.photosImageView setHidden:YES];
    }
    
    if (status.retweeted_status) { // 有转发微博
        [self.retweetView setHidden:NO];
        [self.retweetView setFrame:statusFrame.retweetViewFrame];
        
        [self.retweetContentLabel setFrame:statusFrame.retweetContentLabelFrame];
        [self.retweetContentLabel setAttributedText:status.retweetedAttributedText];
        
        if (status.retweeted_status.pic_urls.count) { // 转发微博有图片
            [self.retweetPhotosImageView setHidden:NO];
            self.retweetPhotosImageView.photos = status.retweeted_status.pic_urls;
            [self.retweetPhotosImageView setFrame:statusFrame.retweetPhotosImageViewFrame];
        } else {
            [self.retweetPhotosImageView setHidden:YES];
        }
    } else {
        [self.retweetView setHidden:YES];
    }
    
    [self.toolbar setFrame:statusFrame.toolbarFrame];
    [self.toolbar setStatus:status];
}

@end
