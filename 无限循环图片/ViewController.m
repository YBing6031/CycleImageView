//
//  ViewController.m
//  无限循环图片
//
//  Created by Jason on 15/8/11.
//  Copyright (c) 2015年 www.jizhan.com. All rights reserved.
//

#import "ViewController.h"
#import "CycleScrollView.h"
#import "CycleView.h"

@interface ViewController ()<CycleViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *images = [NSMutableArray array];
    for (int  i = 5; i<9; i++) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%zi.jpg", i] withExtension:nil];;
        [images addObject:url];
    }
    
    CycleView *cycleView = [[CycleView alloc] initWithFrame:CGRectMake(50, 50, 250, 150) images:images currentIndex:0 didSelectForIndex:^(NSInteger index) {
        NSLog(@"%zi", index);
    }];
    [self.view addSubview:cycleView];
    
//    cycleView.delegate = self;
}

- (void)cycleView:(CycleView *)cycleView didSelectForIndex:(NSInteger)index
{
    NSLog(@"%zi", index);
}

@end
