//
//  JSSOAuthViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSOAuthViewController.h"
#import "AFNetworking.h"

@interface JSSOAuthViewController () <UIWebViewDelegate>

@end

@implementation JSSOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    [webView setFrame:self.view.bounds];
    [webView setDelegate:self];
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1322161785&redirect_uri=http://"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
}

/**
 *  拦截网络请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = request.URL.absoluteString;
    
    NSRange range = [urlString rangeOfString:@"code="];
    if (range.location != NSNotFound) {
        NSString *code = [urlString substringFromIndex:range.location + range.length];
        
        // 获取管理者
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // 拼接参数
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"client_id"] = @"1322161785";
        parameters[@"client_secret"] = @"552b5366bb1d39595ea780c4d24ce174";
        parameters[@"grant_type"] = @"authorization_code";
        parameters[@"code"] = code;
        parameters[@"redirect_uri"] = @"http://";
        
        // 发送POST请求
        [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // 2.00GDDrIGFgeT8B9f9103ff8b0WeMKg
            NSLog(@"请求成功-%@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"请求失败-%@", error);
        }];
    }
    
    return YES;
}

@end
