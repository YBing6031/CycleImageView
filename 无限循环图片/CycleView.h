//
//  CycleView.h
//  无限循环图片
//
//  Created by Jason on 15/8/12.
//  Copyright (c) 2015年 www.jizhan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"

@class CycleView;

typedef void(^CycleViewDidSelectForIndex)(NSInteger index);

@protocol CycleViewDelegate <NSObject>

@optional
- (void)cycleView:(CycleView *)cycleView didSelectForIndex:(NSInteger)index;

@end

@interface CycleView : UIView

@property (strong, nonatomic) CycleScrollView *scrollView;

@property (nonatomic, copy) CycleViewDidSelectForIndex didSelectForIndex;
@property (nonatomic, assign) id<CycleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images currentIndex:(NSInteger)currentIndex didSelectForIndex:(CycleViewDidSelectForIndex)didSelectForIndex;

@end
