//
//  JSSComposeViewController.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/26.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSComposeViewController.h"
#import "JSSOAuthAccountTool.h"
#import "JSSOAuthAccount.h"
#import "JSSTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "JSSKeyboardToolBar.h"

@interface JSSComposeViewController () <UITextViewDelegate>

@property (nonatomic, weak) JSSTextView *textView;
@property (nonatomic, weak) JSSKeyboardToolBar *keybordToolBar;

@end

@implementation JSSComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /**
     *  设置导航栏部分
     */
    [self setupNav];
    
    /**
     *  多行文本输入框
     */
    [self setupInput];
    
    /**
     *  键盘工具条
     */
    [self setupKeybordToolBar];
}

/**
 *  键盘工具条
 */
- (void)setupKeybordToolBar
{
    JSSKeyboardToolBar *keybordToolBar = [[JSSKeyboardToolBar alloc] init];
    [keybordToolBar setHeight:44];
    [keybordToolBar setWidth:self.view.width];
    [keybordToolBar setY:self.view.height - keybordToolBar.height];
    self.keybordToolBar = keybordToolBar;
    [self.view addSubview:keybordToolBar];
}

/**
 *  TextView的监听方法
 */
- (void)textDidChanged
{
    [self.navigationItem.rightBarButtonItem setEnabled:self.textView.hasText];
}

/**
 *  键盘改变的监听方法
 */
- (void)keybordDidChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        [self.keybordToolBar setY:rect.origin.y - self.keybordToolBar.height];
    }];
}

/**
 *  多行文本输入框
 */
- (void)setupInput
{
    JSSTextView *textView = [[JSSTextView alloc] init];
    [textView setFrame:self.view.bounds];
    [textView setPlaceHolder:@"分享新鲜事..."];
    [textView setDelegate:self];
    self.textView = textView;
    [self.view addSubview:textView];
    
    // 文字改变的通知
    [JSSNotificationCenter addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:self.textView];
    
    // 键盘的通知
    [JSSNotificationCenter addObserver:self selector:@selector(keybordDidChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 *  开始拖拽的时候执行的代理方法
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 *  设置导航栏部分
 */
- (void)setupNav
{
    // 导航栏左按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    
    // 导航栏右按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    NSString *prefixStr = @"发微博";
    NSString *subfixStr = [JSSOAuthAccountTool account].name;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setHeight:44];
    [titleLabel setWidth:200];
    [titleLabel setNumberOfLines:0];
    
    NSMutableAttributedString *attributedStrM = [[NSMutableAttributedString alloc] init];
    
    // 大标题
    NSMutableDictionary *prefixAttr = [NSMutableDictionary dictionary];
    prefixAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17];
    NSAttributedString *prefixAttributedStr = [[NSAttributedString alloc] initWithString:prefixStr attributes:prefixAttr];
    [attributedStrM appendAttributedString:prefixAttributedStr];
    
    // 小标题
    NSMutableDictionary *subfixAttr = [NSMutableDictionary dictionary];
    subfixAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    subfixAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    NSAttributedString *subfixAttributedStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", subfixStr] attributes:subfixAttr];
    [attributedStrM appendAttributedString:subfixAttributedStr];
    
    [titleLabel setAttributedText:attributedStrM];
    
    // 导航栏标题
    [self.navigationItem setTitleView:titleLabel];
}

/**
 *  取消按钮的监听方法
 */
- (void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送按钮的监听方法
 */
- (void)send
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = [JSSOAuthAccountTool account].access_token;
    parameters[@"status"] = self.textView.text;
    
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
