//
//  JSSStatusCell.h
//  高仿微博
//
//  Created by JiShangsong on 15/6/19.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSSStatusFrame;

@interface JSSStatusCell : UITableViewCell

/**
 *  快速创建UITableViewCell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  微博Frame模型
 */
@property (nonatomic, strong) JSSStatusFrame *statusFrame;

@end
