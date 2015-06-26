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

@interface JSSComposeViewController ()

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
}

/**
 *  多行文本输入框
 */
- (void)setupInput
{
    UITextView *textView = [[UITextView alloc] init];
    [textView setFrame:self.view.frame];
    [self.view addSubview:textView];
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

- (void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    NSLog(@"send");
}

@end
