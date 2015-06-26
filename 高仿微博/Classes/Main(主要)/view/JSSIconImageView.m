//
//  JSSIconImageView.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/22.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSIconImageView.h"
#import "JSSUser.h"
#import "UIImageView+WebCache.h"

@interface JSSIconImageView ()

@property (nonatomic, weak) UIImageView *verifiedImageView;

@end

@implementation JSSIconImageView

- (UIImageView *)verifiedImageView
{
    if (_verifiedImageView == nil) {
        UIImageView *verifiedImageView = [[UIImageView alloc] init];
        [self addSubview:verifiedImageView];
        _verifiedImageView = verifiedImageView;
    }
    return _verifiedImageView;
}

- (void)setUser:(JSSUser *)user
{
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    switch (user.verified_type) {
        case JSSVerifiedTypeNone:
            [self.verifiedImageView setHidden:YES];
            break;
            
        case JSSVerifiedTypePersonal:
            [self.verifiedImageView setImage:[UIImage imageNamed:@"avatar_vip"]];
            [self.verifiedImageView setHidden:NO];
            break;
            
        case JSSVerifiedTypeEnterprice:
        case JSSVerifiedTypeMedia:
        case JSSVerifiedTypeWebsite:
            [self.verifiedImageView setImage:[UIImage imageNamed:@"avatar_enterprise_vip"]];
            [self.verifiedImageView setHidden:NO];
            break;
            
        case JSSVerifiedTypeDaren:
            [self.verifiedImageView setImage:[UIImage imageNamed:@"avatar_grassroot"]];
            [self.verifiedImageView setHidden:NO];
            break;
            
        default:
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.verifiedImageView setSize:self.verifiedImageView.image.size];
    [self.verifiedImageView setX:self.width - self.verifiedImageView.width * 0.8];
    [self.verifiedImageView setY:self.height - self.verifiedImageView.height * 0.8];
}

@end
