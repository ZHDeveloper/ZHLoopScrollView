# ZHLoopScrollView
循环轮播类
使用方法一：

    ZHLoopScrollView *bannerView = [[ZHLoopScrollView alloc] initWithFrame:CGRectMake((size.width-300)*0.5, 80, 300, 130)];
    
    self.bannerView.imageArr = arr;
    
    self.bannerView.clickBlock = ^(ZHLoopScrollView *view, NSUInteger index) {
        NSLog(@"%lu",index);
    };
    
可以分别给类是属性赋值，也可以使用以下方法对属性赋值

    ///便捷的初始化方法
    - (void)initWith:(NSTimeInterval)timeInterval pageTintColor:(UIColor *)pageIndicatorTintColor currentPageTintColor:(UIColor *)currentPageIndicatorTintColor imageArr:(NSArray *)imageArr clickBlock:(ClickBlock)block;

使用方法二：

使用xib来初始化

1. 在xib中指定view的类型为ZHLoopScrollView。
2. 连线到文件中
3. 设置类型的属性
