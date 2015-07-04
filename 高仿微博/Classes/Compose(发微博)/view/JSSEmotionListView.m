//
//  JSSEmotionListView.m
//  高仿微博
//
//  Created by JiShangsong on 15/6/29.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSEmotionListView.h"
#import "JSSEmotionContentView.h"
#define JSSCountPerPage 20

@interface JSSEmotionListView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation JSSEmotionListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        // 上面的滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [scrollView setPagingEnabled:YES];
        [scrollView setDelegate:self];
        
        // 取消水平和垂直滚动条
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        self.scrollView = scrollView;
        [self addSubview:scrollView];
        
        // 下面的分页控件
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        // 设置分页控件的背景图片(KVC)
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [pageControl setHidesForSinglePage:YES];
        
        self.pageControl = pageControl;
        [self addSubview:pageControl];
    }
    return self;
}

/**
 *  拦截表情数组
 */
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 清空子控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 计算分页控件的页数
    NSInteger pageCount = (emotions.count + JSSCountPerPage - 1) / JSSCountPerPage;
    [self.pageControl setNumberOfPages:pageCount];
    
    // 设置滚动视图的内容
    for (NSInteger i = 0; i < pageCount; i++) {
        JSSEmotionContentView *pageView = [[JSSEmotionContentView alloc] init];
        NSInteger location = JSSCountPerPage * i;
        NSInteger leaveCount = emotions.count - location;
        NSInteger length = leaveCount > JSSCountPerPage ? JSSCountPerPage : leaveCount;
        NSRange range = NSMakeRange(location, length);
        NSArray *sunEmotions = [emotions subarrayWithRange:range];
        [pageView setEmotions:sunEmotions];
        [self.scrollView addSubview:pageView];
    }
    
    // 刷新布局
    [self setNeedsLayout];
}

/**
 *  重新布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 下面的分页控件
    [self.pageControl setHeight:35];
    CGPoint center = self.center;
    center.y = self.height - self.pageControl.height / 2;
    [self.pageControl setCenter:center];
    
    // 上面的滚动视图
    [self.scrollView setX:0];
    [self.scrollView setY:0];
    [self.scrollView setWidth:self.width];
    [self.scrollView setHeight:self.height - self.pageControl.height];
    
    // 滚动视图的内容
    NSInteger pageCount = self.scrollView.subviews.count;
    CGFloat pageViewW = self.scrollView.width;
    CGFloat pageViewH = self.scrollView.height;
    [self.scrollView setContentSize:CGSizeMake(pageViewW * pageCount, pageViewH)];
    for (NSInteger i = 0; i < pageCount; i++) {
        UIView *pageView = self.scrollView.subviews[i];
        [pageView setX:pageViewW * i];
        [pageView setY:0];
        [pageView setWidth:pageViewW];
        [pageView setHeight:pageViewH];
    }
}

/**
 *  滚动视图代理方法
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageCount = scrollView.contentOffset.x / scrollView.width;
    [self.pageControl setCurrentPage:pageCount];
}

@end
