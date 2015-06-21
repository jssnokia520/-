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

@interface JSSStatusCell ()

/**
 *  原创微博视图
 */
@property (nonatomic, weak) UIView *originalView;

/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconImageView;

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
@property (nonatomic, weak) UILabel *contentLabel;

/**
 *  图片
 */
@property (nonatomic, weak) UIImageView *photoImageView;

/**
 *  转发微博视图
 */
@property (nonatomic, weak) UIView *retweetView;

/**
 *  转发的微博正文 + 昵称
 */
@property (nonatomic, weak) UILabel *retweetContentLabel;

/**
 *  转发的微博图片
 */
@property (nonatomic, weak) UIImageView *retweetPhotoImageView;

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
    
    
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetContentLabel setNumberOfLines:0];
    [retweetContentLabel setFont:JSSRetweetContentFont];
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    UIImageView *retweetPhotoImageView = [[UIImageView alloc] init];
    self.retweetPhotoImageView = retweetPhotoImageView;
    [self.retweetView addSubview:retweetPhotoImageView];
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
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
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
    
    UILabel *contentLabel = [[UILabel alloc] init];
    [originalView addSubview:contentLabel];
    [contentLabel setNumberOfLines:0];
    self.contentLabel = contentLabel;
    
    UIImageView *photoImageView = [[UIImageView alloc] init];
    [originalView addSubview:photoImageView];
    self.photoImageView = photoImageView;
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
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
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
    
    [self.sourceLabel setFrame:statusFrame.sourceFrame];
    [self.sourceLabel setFont:JSSSourceFont];
    [self.sourceLabel setText:status.source];
    
    [self.contentLabel setFrame:statusFrame.contentFrame];
    [self.contentLabel setFont:JSSContentFont];
    [self.contentLabel setText:status.text];
    
    if (status.pic_urls.count) {
        [self.photoImageView setHidden:NO];
        [self.photoImageView setFrame:statusFrame.photoFrame];
        JSSPhoto *photo = [status.pic_urls lastObject];
        NSURL *url = [NSURL URLWithString:photo.thumbnail_pic];
        [self.photoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    } else {
        [self.photoImageView setHidden:YES];
    }
    
    if (status.retweeted_status) { // 有转发微博
        [self.retweetView setHidden:NO];
        [self.retweetView setFrame:statusFrame.retweetViewFrame];
        
        [self.retweetContentLabel setFrame:statusFrame.retweetContentLabelFrame];
        [self.retweetContentLabel setText:[NSString stringWithFormat:@"@%@ : %@", status.retweeted_status.user.name, status.retweeted_status.text]];
        
        if (status.retweeted_status.pic_urls.count) { // 转发微博有图片
            [self.retweetPhotoImageView setHidden:NO];
            [self.retweetPhotoImageView setFrame:statusFrame.retweetPhotoImageViewFrame];
            JSSPhoto *photo = [status.retweeted_status.pic_urls firstObject];
            NSURL *url = [NSURL URLWithString:photo.thumbnail_pic];
            [self.retweetPhotoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        } else {
            [self.retweetPhotoImageView setHidden:YES];
        }
    } else {
        [self.retweetView setHidden:YES];
    }
    
    [self.toolbar setFrame:statusFrame.toolbarFrame];
    [self.toolbar setStatus:status];
}

@end
