//
//  ViewController.m
//  test
//
//  Created by AdminZhiHua on 15/11/6.
//  Copyright © 2015年 AdminZhiHua. All rights reserved.
//

#import "ViewController.h"
#import "ZHLoopScrollView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ZHLoopScrollView *bannerView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i = 0; i<5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"img_%02d",i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        [arr addObject:image];
    }
    
    self.bannerView.imageArr = arr;
    
    self.bannerView.clickBlock = ^(ZHLoopScrollView *view, NSUInteger index) {
        NSLog(@"%lu",index);
    };
    
//    [self.bannerView initWith:6 pageTintColor:nil currentPageTintColor:nil imageArr:arr clickBlock:^(ScrollBannerView *view, NSUInteger index) {
//        NSLog(@"%lu",index);
//    }];

    
}

@end
