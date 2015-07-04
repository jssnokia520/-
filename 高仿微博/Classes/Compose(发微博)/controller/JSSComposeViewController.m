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
#import "JSSEmotionTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "JSSKeyboardToolBar.h"
#import "JSSComposePhotosView.h"
#import "JSSEmotionKeyboard.h"
#import "JSSEmotion.h"
#import "JSSEmotionTool.h"

@interface JSSComposeViewController () <UITextViewDelegate, JSSKeyboardToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) JSSEmotionTextView *textView;
@property (nonatomic, weak) JSSKeyboardToolBar *keybordToolBar;
@property (nonatomic, weak) JSSComposePhotosView *photosView;
@property (nonatomic, assign) BOOL isSwitchingKeyboard;

/**
 *  这里一定要使用strong强引用
 */
@property (nonatomic, strong) JSSEmotionKeyboard *keyboard;

@end

@implementation JSSComposeViewController

/**
 *  懒加载表情键盘
 */
- (JSSEmotionKeyboard *)keyboard
{
    if (_keyboard == nil) {
        _keyboard = [[JSSEmotionKeyboard alloc] init];
        [_keyboard setWidth:self.view.width];
        [_keyboard setHeight:216];
    }
    return _keyboard;
}

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
    
    /**
     *  图像视图
     */
    [self setupPhotosView];
}

/**
 *  图像视图
 */
- (void)setupPhotosView
{
    JSSComposePhotosView *photosView = [[JSSComposePhotosView alloc] init];
    [photosView setY:100];
    [photosView setWidth:self.view.width];
    [photosView setHeight:self.view.height];
    self.photosView = photosView;
    [self.textView addSubview:photosView];
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
    [keybordToolBar setDelegate:self];
    self.keybordToolBar = keybordToolBar;
    [self.view addSubview:keybordToolBar];
}

/**
 *  键盘工具类的代理方法
 */
- (void)keyboardToolBar:(JSSKeyboardToolBar *)toolBar didClickButton:(JSSKeyboardButtonType)buttonType
{
    switch (buttonType) {
        case JSSKeyboardButtonCamera:
            [self openCamera];
            break;
        case JSSKeyboardButtonPicture:
            [self openAlbum];
            break;
        case JSSKeyboardButtonMention:
            
            break;
        case JSSKeyboardButtonTrend:
            
            break;
        case JSSKeyboardButtonMotion:
            [self openEmotionKeyboard];
            break;
    }
}

/**
 *  打开表情键盘
 */
- (void)openEmotionKeyboard
{
    self.isSwitchingKeyboard = YES;
    
    if (self.textView.inputView == nil) { // 系统键盘
        [self.keybordToolBar setIsEmotionKeyboard:YES];
        [self.textView setInputView:self.keyboard];
    } else { // 表情键盘
        [self.keybordToolBar setIsEmotionKeyboard:NO];
        [self.textView setInputView:nil];
    }
    
    [self.textView endEditing:YES];
    
    self.isSwitchingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
}

/**
 *  打开相机
 */
- (void)openCamera
{
    [self openImagePicker:UIImagePickerControllerSourceTypeCamera];
}

/**
 *  打开相册
 */
- (void)openAlbum
{
    [self openImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

/**
 *  打开相机或者是相册
 */
- (void)openImagePicker:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:type];
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

/**
 *  imagePicker代理方法
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if (self.isSwitchingKeyboard) {
        return;
    }
    
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
    JSSEmotionTextView *textView = [[JSSEmotionTextView alloc] init];
    [textView setFrame:self.view.bounds];
    [textView setPlaceHolder:@"分享新鲜事..."];
    [textView setDelegate:self];
    // 让TextView成为第一响应者
    [textView becomeFirstResponder];
    self.textView = textView;
    [self.view addSubview:textView];
    
    // 文字改变的通知
    [JSSNotificationCenter addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:self.textView];
    
    // 键盘的通知
    [JSSNotificationCenter addObserver:self selector:@selector(keybordDidChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 监听键盘视图上按钮被点中
    [JSSNotificationCenter addObserver:self selector:@selector(emotionDidSelected:) name:JSSEmotionDidSelected object:nil];
    
    // 表情键盘删除的通知
    [JSSNotificationCenter addObserver:self selector:@selector(emotionDidDeleted) name:JSSEmotionDidDeleted object:nil];
}
/**
 *  键盘视图上按钮被点中的监听方法
 */
- (void)emotionDidDeleted
{
    // 往回删除
    [self.textView deleteBackward];
}

/**
 *  键盘视图上按钮被点中的监听方法
 */
- (void)emotionDidSelected:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    JSSEmotion *emotion = userInfo[@"emotion"];
    [self.textView setEmotion:emotion];
    [self textDidChanged];
    
    // 存储表情
    [JSSEmotionTool addEmotion:emotion];
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
    // 判断是否有图片
    if (self.photosView.images.count) { // 有图片
        [self sendWithImage];
    } else { // 没有图片
        [self sendWithoutImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  有图片
 */
- (void)sendWithImage
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = [JSSOAuthAccountTool account].access_token;
    parameters[@"status"] = self.textView.sendText;
    
    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image = [self.photosView.images firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpeg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

/**
 *  没有图片
 */
- (void)sendWithoutImage
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = [JSSOAuthAccountTool account].access_token;
    parameters[@"status"] = self.textView.sendText;
    
    
    
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

@end
