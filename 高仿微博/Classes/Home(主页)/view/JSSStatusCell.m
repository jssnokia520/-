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

@interface JSSStatusCell ()

/**
 *  上半部分视图的父视图
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
        cell = [[self alloc] init];
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
        UIView *originalView = [[UIView alloc] init];
        self.originalView = originalView;
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [originalView addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [originalView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UIImageView *vipImageView = [[UIImageView alloc] init];
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
        self.contentLabel = contentLabel;
        
        UIImageView *photoImageView = [[UIImageView alloc] init];
        [originalView addSubview:photoImageView];
        self.photoImageView = photoImageView;
    }
    return self;
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
    [self.nameLabel setText:user.name];
    
    [self.vipImageView setFrame:statusFrame.vipFrame];
    [self.vipImageView setImage:[UIImage imageNamed:@"common_icon_membership_level1"]];
    
    [self.timeLabel setFrame:statusFrame.timeFrame];
    
    [self.sourceLabel setFrame:statusFrame.sourceFrame];
    
    [self.contentLabel setFrame:statusFrame.contentFrame];
    [self.contentLabel setText:status.text];
    
    [self.photoImageView setFrame:statusFrame.photoFrame];
}

@end
