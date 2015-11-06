//
//  ScrollBannerView.h
//  test
//
//  Created by AdminZhiHua on 15/11/6.
//  Copyright © 2015年 AdminZhiHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHLoopScrollView;
typedef void (^ClickBlock)(ZHLoopScrollView *view,NSUInteger index);

@interface ZHLoopScrollView : UIView

///定时器触发的时间
@property (nonatomic,assign) NSTimeInterval timeInterval;

///pageControl的正常颜色,默认是黑色
@property (nonatomic,strong) UIColor *pageTintColor;

///pageControl的当前颜色,默认是白色
@property (nonatomic,strong) UIColor *currentTintColor;

///图片数组
@property (nonatomic,strong) NSArray *imageArr;

///图片点击的block
@property (nonatomic,strong) ClickBlock clickBlock;

///便捷的初始化方法
- (void)initWith:(NSTimeInterval)timeInterval pageTintColor:(UIColor *)pageIndicatorTintColor currentPageTintColor:(UIColor *)currentPageIndicatorTintColor imageArr:(NSArray *)imageArr clickBlock:(ClickBlock)block;

@end
