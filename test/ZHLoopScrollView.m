//
//  ScrollBannerView.m
//  test
//
//  Created by AdminZhiHua on 15/11/6.
//  Copyright © 2015年 AdminZhiHua. All rights reserved.
//

#import "ZHLoopScrollView.h"

@interface ZHLoopScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollerView;

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIImageView *centerImageView;

@property (nonatomic,assign) NSUInteger currentIndex;

@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation ZHLoopScrollView

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.tag = 0;
    }
    return _leftImageView;
}

- (UIImageView *)centerImageView {
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] init];
        _centerImageView.tag = 1;
        _centerImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidClick)];
        [_centerImageView addGestureRecognizer:tapGest];
    }
    return _centerImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.tag = 2;
    }
    return _rightImageView;
}

- (UIScrollView *)scrollerView {
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] init];
        [self addSubview:_scrollerView];
        _scrollerView.bounces = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.pagingEnabled = YES;
        _scrollerView.delegate = self;
        CGSize size = self.bounds.size;
        _scrollerView.contentOffset = CGPointMake(size.width, 0);
        _scrollerView.contentSize = CGSizeMake(3*size.width, size.height);
    }
    return _scrollerView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        [self addSubview:_pageControl];
        _pageControl.pageIndicatorTintColor = self.pageTintColor;
        _pageControl.currentPageIndicatorTintColor = self.currentTintColor;
    }
    return _pageControl;
}

- (void)setPageTintColor:(UIColor *)pageTintColor {
    _pageTintColor = pageTintColor;
    self.pageControl.pageIndicatorTintColor = pageTintColor;
}

- (void)setCurrentTintColor:(UIColor *)currentTintColor {
    self.pageControl.currentPageIndicatorTintColor = currentTintColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        [self initAndLayout];

    }
    
    return self;
}

- (void)awakeFromNib {
    
    [self initAndLayout];

}

- (void)initAndLayout {
    
    [self setScrollerViewConstraints];
    [self setImageViewConstraints:self.leftImageView];
    [self setImageViewConstraints:self.centerImageView];
    [self setImageViewConstraints:self.rightImageView];
    [self setPageControlConstraints];
    
    self.timeInterval = 4;
    self.pageTintColor = [UIColor blackColor];
    self.currentTintColor = [UIColor whiteColor];

}

- (void)setScrollerViewConstraints {
    
    self.scrollerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constWith = [NSLayoutConstraint constraintWithItem:self.scrollerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *constHeight = [NSLayoutConstraint constraintWithItem:self.scrollerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *constCenterX = [NSLayoutConstraint constraintWithItem:self.scrollerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *constCenterY = [NSLayoutConstraint constraintWithItem:self.scrollerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraints:@[constWith,constHeight,constCenterX,constCenterY]];
}

- (void)setImageViewConstraints:(UIImageView *)view {
    
    [self.scrollerView addSubview:view];
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGSize size = self.bounds.size;
    
    NSLayoutConstraint *constWith = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.scrollerView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *constHeight = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.scrollerView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *constCenterX = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.scrollerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:view.tag*size.width];
    NSLayoutConstraint *constCenterY = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.scrollerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.scrollerView addConstraints:@[constWith,constHeight,constCenterX,constCenterY]];
}

- (void)setPageControlConstraints {
    
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGSize viewSize = self.bounds.size;
    
    NSLayoutConstraint *constCenterX = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *constCenterY = [NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:viewSize.height*0.5-10];
    
    [self addConstraint:constCenterX];
    [self addConstraint:constCenterY];
    
}

- (void)setImageArr:(NSArray *)imageArr {
    _imageArr = imageArr;
    
    [self reloadData];
    
}

- (void)reloadData {
    
    self.leftImageView.image = [self.imageArr lastObject];
    self.centerImageView.image = [self.imageArr firstObject];
    self.rightImageView.image = self.imageArr[1];
    
    self.pageControl.numberOfPages = self.imageArr.count;
    
    [self resumeTimer];
}

- (void)resumeTimer {
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.timeInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    
    _timer = timer;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self resumeTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (!self.imageArr) return;
    
    NSUInteger leftImageIndex,rightImageIndex;
    
    NSUInteger imageCount = self.imageArr.count;
    
    CGPoint offSet = scrollView.contentOffset;
    CGSize size = scrollView.bounds.size;
    
    if (offSet.x>size.width) {//右划
        _currentIndex = (_currentIndex+1)%imageCount;
    }else if (offSet.x<size.width){//左划
        _currentIndex = (_currentIndex+imageCount-1)%imageCount;
    }

    self.centerImageView.image = self.imageArr[_currentIndex];
    
    leftImageIndex = (_currentIndex+imageCount-1)%imageCount;
    rightImageIndex = (_currentIndex+1)%imageCount;
    
    self.leftImageView.image = self.imageArr[leftImageIndex];
    self.rightImageView.image = self.imageArr[rightImageIndex];
    
    [scrollView setContentOffset:CGPointMake(size.width, 0)];
    
    self.pageControl.currentPage = _currentIndex;
}

- (void)nextImage {
    
    NSUInteger imageCount = self.imageArr.count;
    _currentIndex = (_currentIndex+1)%imageCount;
    
    _centerImageView.image = self.imageArr[_currentIndex];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_centerImageView.layer addAnimation:animation forKey:nil];
    
    self.pageControl.currentPage = _currentIndex;

}

- (void)initWith:(NSTimeInterval)timeInterval pageTintColor:(UIColor *)pageTintColor currentPageTintColor:(UIColor *)currentTintColor imageArr:(NSArray *)imageArr clickBlock:(ClickBlock)block {
    
    self.timeInterval = timeInterval;
    self.pageTintColor = pageTintColor;
    self.currentTintColor = currentTintColor;
    self.imageArr = imageArr;
    
    self.clickBlock = block;
}

- (void)imageDidClick {
    
    if (self.clickBlock) {
        self.clickBlock(self,self.currentIndex);
    }
    
}

@end
