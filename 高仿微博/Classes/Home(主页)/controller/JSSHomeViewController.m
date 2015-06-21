//
//  JSSHomeViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSHomeViewController.h"
#import "JSSDropDownMenu.h"
#import "JSSTitleMenuViewController.h"
#import "JSSOAuthAccount.h"
#import "JSSOAuthAccountTool.h"
#import "AFNetworking.h"
#import "JSSTitleButton.h"
#import "UIImageView+WebCache.h"
#import "JSSUser.h"
#import "JSSStatus.h"
#import "MJExtension.h"
#import "JSSLoadMoreFooter.h"
#import "JSSStatusCell.h"
#import "JSSStatusFrame.h"

@interface JSSHomeViewController () <JSSDropDownMenuDelegate>

/**
 *  微博控件
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation JSSHomeViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView setBackgroundColor:JSSColor(241, 241, 241)];
    
    // 自定义按钮代替导航条的标题视图
    [self setUpTitleButton];
    
    // 更新首页
    [self updateHomePage];
    
    // 添加下拉刷新控件
    [self setRefreshControl];
    
    // 添加上拉刷新控件
    [self setFooter];
    
    // 每隔一段时间自动刷新微博
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(autoRefresh) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  自动刷新微博
 */
- (void)autoRefresh
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    JSSOAuthAccount *account = [JSSOAuthAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;
    
    [manager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [self setBadge:[responseObject[@"status"] stringValue]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setBadge:(NSString *)unread
{
    if (unread.integerValue == 0) {
        [self.tabBarItem setBadgeValue:nil];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    } else {
        [self.tabBarItem setBadgeValue:unread];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:unread.integerValue];
    }
}

/**
 *  添加上拉刷新控件
 */
- (void)setFooter {
    JSSLoadMoreFooter *footer = [JSSLoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
    [self.tableView.tableFooterView setHidden:YES];
}

/**
 *  添加下拉刷新控件
 */
- (void)setRefreshControl
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    // 开始刷新
    [refreshControl beginRefreshing];
    [self refresh:refreshControl];
}

/**
 *  监听下拉刷新控件
 */
- (void)refresh:(UIRefreshControl *)refreshControl
{
    [self.tabBarItem setBadgeValue:nil];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    // 再次发送请求获取数据
    JSSOAuthAccount *account = [JSSOAuthAccountTool account];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    // 获取第一条微博
    JSSStatusFrame *statusFrame = [self.statusFrames firstObject];
    if (statusFrame.status) {
        parameters[@"since_id"] = statusFrame.status.idstr;
    }
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 结束刷新
        [refreshControl endRefreshing];
        
        // 获取微博数据
        NSArray *newStatuses = [JSSStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newStatusFrames = [self statusFramesWithStatus:newStatuses];
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newStatusFrames atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 显示提示标签
        [self setTipLabel:newStatusFrames.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 结束刷新
        [refreshControl endRefreshing];
        NSLog(@"%@", error);
    }];
}

- (NSArray *)statusFramesWithStatus:(NSArray *)statuses
{
    NSMutableArray *statusFrames = [NSMutableArray array];
    
    for (JSSStatus *status in statuses) {
        JSSStatusFrame *frame = [[JSSStatusFrame alloc] init];
        frame.status = status;
        [statusFrames addObject:frame];
    }
    
    return statusFrames;
}

/**
 *  显示提示标签
 */
- (void)setTipLabel:(NSInteger)count
{
    // 创建标签
    UILabel *label = [[UILabel alloc] init];
    [label setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setTextColor:[UIColor whiteColor]];
    [label setWidth:self.view.width];
    [label setHeight:35];
    CGFloat labelY = self.navigationController.navigationBar.height - label.height + 20;
    [label setY:labelY];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    if (count == 0) {
        [label setText:@"暂时没有新的微博数据,请稍后再试!"];
    } else {
        [label setText:[NSString stringWithFormat:@"共有%ld条新的微博数据!", count]];
    }

    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        [label setTransform:CGAffineTransformMakeTranslation(0, label.height)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:duration options:UIViewAnimationOptionCurveLinear animations:^{
            [label setTransform:CGAffineTransformIdentity];
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSSStatusCell *cell = [JSSStatusCell cellWithTableView:tableView];
    
    JSSStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    cell.statusFrame = statusFrame;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSSStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

/**
 *  当表格滚动到最末尾的时候显示上拉刷新控件
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 如果没有数据就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.hidden == NO) {
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    
    if (offsetY >= judgeOffsetY) {
        [self.tableView.tableFooterView setHidden:NO];
        
        // 加载更多微博数据
        [self loadMoreStatus];
    }
}

/**
 *  加载更多微博数据
 */
- (void)loadMoreStatus
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    JSSOAuthAccount *account = [JSSOAuthAccountTool account];
    parameters[@"access_token"] = account.access_token;
    JSSStatusFrame *statusFrame = [self.statusFrames lastObject];
    if (statusFrame.status) {
        parameters[@"max_id"] = @(statusFrame.status.idstr.longLongValue);
    }

    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSArray *statuses = [JSSStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *statusFrames = [self statusFramesWithStatus:statuses];
        [self.statusFrames addObjectsFromArray:statusFrames];
        [self.tableView reloadData];
        [self.tableView.tableFooterView setHidden:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.tableFooterView setHidden:YES];
    }];
}

// 更新首页
- (void)updateHomePage
{
    JSSOAuthAccount *account = [JSSOAuthAccountTool account];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;
    
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        JSSUser *user = [JSSUser objectWithKeyValues:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        [account setName:user.name];
        [JSSOAuthAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

// 自定义按钮代替导航条的标题视图
- (void)setUpTitleButton
{
    // 导航条左边按钮
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"]];
    
    // 导航条右边按钮
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"]];
    
    JSSTitleButton *titleButton = [[JSSTitleButton alloc] init];
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *name = [JSSOAuthAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    [self.navigationItem setTitleView:titleButton];
}

- (void)titleClick:(id)from
{
    JSSDropDownMenu *menu = [JSSDropDownMenu menu];
    
    [menu setDelegate:self];
    
    JSSTitleMenuViewController *controller = [[JSSTitleMenuViewController alloc] init];
    controller.view.height = 200;
    controller.view.width = 200;
    [menu setContentController:controller];
    
    [menu showFromView:from];
}

- (void)dropDownMenuDidDismiss:(JSSDropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    [titleButton setSelected:NO];
}

- (void)dropDownMenuDidShow:(JSSDropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    [titleButton setSelected:YES];
}

- (void)friendsearch
{
    NSLog(@"friendsearch");
}

- (void)pop
{
    NSLog(@"pop");
}

@end
