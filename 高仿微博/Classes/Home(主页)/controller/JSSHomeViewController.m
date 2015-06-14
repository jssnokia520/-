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

@interface JSSHomeViewController () <JSSDropDownMenuDelegate>

@property (nonatomic, strong) NSArray *statuses;

@end

@implementation JSSHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 自定义按钮代替导航条的标题视图
    [self setUpTitleButton];
    
    // 更新首页
    [self updateHomePage];
    
    // 加载微博数据
    [self loadNewStatus];
}

/**
 *  加载微博数据
 */
- (void)loadNewStatus
{
    JSSOAuthAccount *account = [JSSOAuthAccountTool account];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"count"] = @10;
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        self.statuses = responseObject[@"statuses"];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"status";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    NSDictionary *status = self.statuses[indexPath.row];
    
    [cell.textLabel setText:status[@"user"][@"name"]];
    [cell.detailTextLabel setText:status[@"text"]];
    [cell.imageView sd_setImageWithURL:status[@"user"][@"profile_image_url"] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    return cell;
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
        [titleButton setTitle:responseObject[@"name"] forState:UIControlStateNormal];
        
        [account setName:responseObject[@"name"]];
        [JSSOAuthAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
    // [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

- (void)dropDownMenuDidShow:(JSSDropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    [titleButton setSelected:YES];
    // [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
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
