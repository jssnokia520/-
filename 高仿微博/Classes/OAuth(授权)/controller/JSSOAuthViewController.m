//
//  JSSOAuthViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSOAuthViewController.h"
#import "AFNetworking.h"
#import "JSSTabBarViewController.h"
#import "JSSNewfeatureViewController.h"
#import "MBProgressHUD+MJ.h"
#import "JSSOAuthAccount.h"
#import "JSSOAuthAccountTool.h"

@interface JSSOAuthViewController () <UIWebViewDelegate>

@end

@implementation JSSOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    [webView setFrame:self.view.bounds];
    [webView setDelegate:self];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1322161785&redirect_uri=http://www.520it.com"];
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
        [self accessTokenWithCode:code];
        
        // 禁止请求
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载数据..."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (void)accessTokenWithCode:(NSString *)code
{
    // 获取管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = @"1322161785";
    parameters[@"client_secret"] = @"552b5366bb1d39595ea780c4d24ce174";
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = @"http://www.520it.com";
    
    // 发送POST请求
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD  hideHUD];
        
        // 存储账号信息
        JSSOAuthAccount *account = [JSSOAuthAccount accountWithDict:responseObject];
        [JSSOAuthAccountTool saveAccount:account];
        
        NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *key = @"CFBundleVersion";
        // 获取上次打开的版本
        NSString *lastVersion = [defaults valueForKeyPath:key];
        
        // 获取本次打开的版本
        NSString *currentVersion = infoDict[key];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        // 3.判断是否是新版本
        if ([lastVersion isEqualToString:currentVersion]) { // 两次版本不同
            [window setRootViewController:[[JSSTabBarViewController alloc] init]];
        } else {
            [window setRootViewController:[[JSSNewfeatureViewController alloc] init]];
            
            // 将新版本写入沙盒
            [defaults setValue:currentVersion forKey:key];
            [defaults synchronize];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

@end
