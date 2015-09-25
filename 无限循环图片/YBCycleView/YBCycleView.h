//
//  CycleView.h
//  无限循环图片
//
//  Created by Jason on 15/8/12.
//  Copyright (c) 2015年 www.jizhan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBCycleScrollView.h"

@class YBCycleView;

typedef NS_ENUM(NSInteger, YBCycleViewPageControlShowStyle) {
    YBCycleViewPageControlShowStyleCenter = 0,//没有
    YBCycleViewPageControlShowStyleLeft = 1,
    YBCycleViewPageControlShowStyleRight = 2,
    YBCycleViewPageControlShowStyleNone = 3,
    YBCycleViewPageControlShowStyleDefault = YBCycleViewPageControlShowStyleCenter
};

/**
 *  点击循环视图的图片触发的block
 *
 *  @param index 图片索引
 */
typedef void(^YBCycleViewDidSelectForIndex)(NSInteger index);

@protocol YBCycleViewDelegate <NSObject>

@optional
/**
 *  点击循环视图的图片触发 *
 *
 *  @param index     图片索引
 */
- (void)cycleView:(YBCycleView *)cycleView didSelectForIndex:(NSInteger)index;

@end

@interface YBCycleView : UIView

@property (strong, nonatomic, readonly) YBCycleScrollView *scrollView;

@property (nonatomic, assign) YBCycleViewPageControlShowStyle pageControlShowStyle;

@property (nonatomic, assign) NSTimeInterval bannerTimeInterval;
@property (nonatomic, assign) BOOL timerEnable;

@property (nonatomic, copy) YBCycleViewDidSelectForIndex didSelectForIndex;
@property (nonatomic, assign) id<YBCycleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex;
+ (instancetype)cycleViewWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex didSelectForIndex:(YBCycleViewDidSelectForIndex)didSelectForIndex;
+ (instancetype)cycleViewWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex didSelectForIndex:(YBCycleViewDidSelectForIndex)didSelectForIndex;

@end
