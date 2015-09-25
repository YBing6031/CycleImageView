//
//  CycleScrollView.m
//  AlbumDemo
//
//  Created by aoyolo1 on 15/5/1.
//  Copyright (c) 2015年 aoyolo1. All rights reserved.
//

#import "YBCycleScrollView.h"
#import <UIImageView+WebCache.h>

NSString *const TimerRestartNotification = @"TimerRestartNotification";

@interface YBCycleScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *images;

@property (nonatomic, strong) UIImageView *preImageView;
@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UIImageView *nextImageView;
@property (nonatomic, copy) IndexChange indexBlock;

@end

@implementation YBCycleScrollView

- (void)setImages:(NSArray *)images
{
    NSMutableArray *imageArr = [NSMutableArray arrayWithArray:images];
    if (images.count == 0) {
        imageArr = nil;
    }
    else if (images.count == 1) {
        [imageArr addObject:images[0]];
        [imageArr addObject:images[0]];
    }
    else if (images.count == 2) {
        [imageArr addObject:images[0]];
        [imageArr addObject:images[1]];
    }
    _images = imageArr;
}

- (void)valueChange:(UIPageControl *)pageControl
{
    self.currentIndex = [self beyondBoundWithIndex:pageControl.currentPage];
    [self configImages];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self setContentOffset:CGPointMake(self.bounds.size.width * 2, 0) animated:YES];
}

- (void)_initImageViews
{
    self.preImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.preImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    self.currentImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * 2, 0, self.bounds.size.width, self.bounds.size.height)];
    self.nextImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.preImageView.clipsToBounds = YES;
    self.currentImageView.clipsToBounds = YES;
    self.nextImageView.clipsToBounds = YES;
    [self addSubview:_preImageView];
    [self addSubview:_currentImageView];
    [self addSubview:_nextImageView];
}

- (NSInteger)beyondBoundWithIndex:(NSInteger)index {
    if (index < 0)
    {
        index = self.images.count - 1;
    }
    else if (index > self.images.count - 1)
    {
        index = 0;
    }
    return index;
}

- (void)configImages
{
    NSInteger preIndex = [self beyondBoundWithIndex:_currentIndex - 1];
    NSInteger nextIndex = [self beyondBoundWithIndex:_currentIndex + 1];
    [self.preImageView sd_setImageWithURL:[NSURL URLWithString:self.images[preIndex]]];
    [self.currentImageView sd_setImageWithURL:[NSURL URLWithString:self.images[_currentIndex]]];
    [self.nextImageView sd_setImageWithURL:[NSURL URLWithString:self.images[nextIndex]]];
    [self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
}

- (instancetype)initWithFrame:(CGRect)frame andImages:(NSArray *)images andCurrentIndex:(NSInteger)index andIndexChange:(IndexChange)block
{
    if (self = [super initWithFrame:frame])
    {
        self.images = images;
        self.currentIndex = index;
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor blackColor];
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        [self _initImageViews];
        self.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        [self configImages];
        self.indexBlock = block;
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //定时器重新启动
    [[NSNotificationCenter defaultCenter] postNotificationName:TimerRestartNotification object:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.flag) {
        [self configImages];
        self.flag = NO;
        return;
    }
    CGFloat xOffset = scrollView.contentOffset.x;
    if (xOffset <= 0)
    {
        self.currentIndex = [self beyondBoundWithIndex:_currentIndex - 1];
        [self configImages];
    }
    else if (xOffset >= 2*self.bounds.size.width)
    {
        self.currentIndex = [self beyondBoundWithIndex:_currentIndex + 1];
        [self configImages];
    }
    if (_indexBlock)
    {
        self.indexBlock(_currentIndex);
    }
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (self.flag) {
//        [self configImages];
//        self.flag = NO;
//        return;
//    }
//    CGFloat xOffset = scrollView.contentOffset.x;
//    if (xOffset <= self.bounds.size.width)
//    {
//        self.currentIndex = [self beyondBoundWithIndex:_currentIndex - 1];
//        [self configImages];
//    }
//    else if (xOffset >= 2*self.bounds.size.width)
//    {
//        self.currentIndex = [self beyondBoundWithIndex:_currentIndex + 1];
//        [self configImages];
//    }
//    if (_indexBlock)
//    {
//        self.indexBlock(_currentIndex);
//    }
//}

@end
