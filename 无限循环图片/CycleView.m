//
//  CycleView.m
//  无限循环图片
//
//  Created by Jason on 15/8/12.
//  Copyright (c) 2015年 www.jizhan.com. All rights reserved.
//

#import "CycleView.h"

@interface CycleView ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIPageControl *pageControl;

@property (assign, nonatomic) NSInteger index;

@end

@implementation CycleView

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) andImages:images andCurrentIndex:currentIndex andIndexChange:^(NSInteger index) {
            self.pageControl.currentPage = index;
        }];
        [self addSubview:self.scrollView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.scrollView addGestureRecognizer:tap];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-30, frame.size.width, 30)];
        self.pageControl.numberOfPages = images.count;
        self.pageControl.userInteractionEnabled = YES;
        self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
//        self.pageControl.backgroundColor = [UIColor blackColor];
        [self.pageControl addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventValueChanged];
        self.pageControl.backgroundColor = [UIColor clearColor];
        [self addSubview:self.pageControl];
        
        //启动定时器
        NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex didSelectForIndex:(CycleViewDidSelectForIndex)didSelectForIndex
{
    self = [self initWithFrame:frame images:images currentIndex:currentIndex];
    if (self) {
        self.didSelectForIndex = didSelectForIndex;
    }
    return self;
}

- (void)timerAction:(NSTimer *)timer
{
    self.scrollView.currentIndex = [self.scrollView beyondBoundWithIndex:self.scrollView.currentIndex];
    self.pageControl.currentPage = self.scrollView.currentIndex;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    if (_didSelectForIndex != nil) {
        _didSelectForIndex(self.scrollView.currentIndex);
    }
    if ([_delegate respondsToSelector:@selector(cycleView:didSelectForIndex:)]) {
        [_delegate cycleView:self didSelectForIndex:self.scrollView.currentIndex];
    }
}

- (void)changeIndex:(UIPageControl *)pageCtl
{
    self.scrollView.flag = YES;
    self.scrollView.currentIndex = pageCtl.currentPage;
}

@end
