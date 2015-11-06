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

@property (nonatomic,assign) NSTimeInterval timeInterval;

@property (nonatomic,strong) UIColor *pageTintColor;

@property (nonatomic,strong) UIColor *currentTintColor;

@property (nonatomic,strong) NSArray *imageArr;

@property (nonatomic,strong) ClickBlock clickBlock;

///便捷的初始化方法
- (void)initWith:(NSTimeInterval)timeInterval pageTintColor:(UIColor *)pageIndicatorTintColor currentPageTintColor:(UIColor *)currentPageIndicatorTintColor imageArr:(NSArray *)imageArr clickBlock:(ClickBlock)block;

@end
