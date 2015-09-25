//
//  ViewController.m
//  无限循环图片
//
//  Created by Jason on 15/8/11.
//  Copyright (c) 2015年 www.jizhan.com. All rights reserved.
//

#import "ViewController.h"
#import "YBCycleView.h"

@interface ViewController ()<YBCycleViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *images = [NSMutableArray array];
    for (int  i = 0; i<9; i++) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%zi.jpg", i] withExtension:nil];
        [images addObject:url.absoluteString];
    }
    
    YBCycleView *cycleView = [[YBCycleView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 200) images:images currentIndex:0 didSelectForIndex:^(NSInteger index) {
        NSLog(@"%zi", index);
    }];
    cycleView.pageControlShowStyle = YBCycleViewPageControlShowStyleCenter;
    [self.view addSubview:cycleView];
    
//    cycleView.delegate = self;
}

- (void)cycleView:(YBCycleView *)cycleView didSelectForIndex:(NSInteger)index
{
    NSLog(@"点击了 %zi", index);
}

@end
