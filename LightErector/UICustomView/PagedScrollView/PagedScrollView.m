//
//  PagedScrollView.m
//  TOYOTA_ZhijiaX
//
//  Created by jayden on 14-8-1.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import "PagedScrollView.h"
#import "NSTimer+Addition.h"

@interface PagedScrollView() <UIScrollViewDelegate>
{
@protected
    NSMutableArray *contentViews;
}
@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) NSArray *imageURLs;
@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic, assign) NSInteger totalPageCount;
@property (nonatomic, strong) NSTimer *autoScrollTimer;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *pageControlConstraints;
@end

@implementation PagedScrollView

- (id)initWithFrame:(CGRect)frame autoScroll:(BOOL)autoScroll
{
    self = [self initWithFrame:frame];
    _autoScroll=autoScroll;
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
        
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.pageControl];
        NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl]-0-|"
                                                                                   options:kNilOptions
                                                                                   metrics:nil
                                                                                     views:@{@"pageControl": self.pageControl}];
        
        NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[pageControl]-|"
                                                                                   options:kNilOptions
                                                                                   metrics:nil
                                                                                     views:@{@"pageControl":self.pageControl}];
        
        self.pageControlConstraints = [NSMutableArray arrayWithArray:pageControlVConstraints];
        [self.pageControlConstraints addObjectsFromArray:pageControlHConstraints];
        
        [self addConstraints:self.pageControlConstraints];
    }
    return self;
}

-(void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll=autoScroll;
    if (!autoScroll) {
        if(self.autoScrollTimer){
            [self.autoScrollTimer pauseTimer];
        }
    }else{
        [self setScrollInterval:self.scrollInterval];
    }
}

-(void)setScrollInterval:(NSUInteger)scrollInterval
{
    _scrollInterval=scrollInterval;
    if (_autoScroll) {
        if(_scrollInterval<=0.0){
            if(self.autoScrollTimer){
                [self.autoScrollTimer pauseTimer];
            }
        }else{
            if(!self.autoScrollTimer){
                self.autoScrollTimer=[NSTimer scheduledTimerWithTimeInterval:_scrollInterval
                                                                      target:self
                                                                    selector:@selector(animationTimerDidFired:)
                                                                    userInfo:nil
                                                                     repeats:YES];
            }
            if(self.totalPageCount<=0){
                [self.autoScrollTimer pauseTimer];
            }
        }
    }
}

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPageCount = totalPagesCount();
    self.pageControl.numberOfPages=_totalPageCount;
    if (_totalPageCount > 0) {
        [self configContentViews];
        if(self.autoScrollTimer){
            [self.autoScrollTimer resumeTimerAfterTimeInterval:self.scrollInterval];
        }
    }
}

#pragma mark - 私有函数

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (contentViews == nil) {
        contentViews = [@[] mutableCopy];
    }
    [contentViews removeAllObjects];
    if (totalViewsArray){
        [contentViews addObject:totalViewsArray[previousPageIndex]];
        [contentViews addObject:totalViewsArray[_currentPageIndex]];
        [contentViews addObject:totalViewsArray[rearPageIndex]];
    } else if (self.fetchContentViewAtIndex) {
        [contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
        [contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(self.autoScrollTimer){
        [self.autoScrollTimer pauseTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(self.autoScrollTimer){
        [self.autoScrollTimer resumeTimerAfterTimeInterval:self.scrollInterval];
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage=_currentPageIndex;
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        [self configContentViews];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}

#pragma mark -
- (void)setPageControlPosition:(PageControlPosition)pageControlPosition
{
    NSString *vFormat = nil;
    NSString *hFormat = nil;
    
    switch (pageControlPosition) {
        case PageControlPosition_TopLeft: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:|-[pageControl]";
            break;
        }
            
        case PageControlPosition_TopCenter: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:|[pageControl]|";
            break;
        }
            
        case PageControlPosition_TopRight: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:[pageControl]-|";
            break;
        }
            
        case PageControlPosition_BottomLeft: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:|-[pageControl]";
            break;
        }
            
        case PageControlPosition_BottomCenter: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:|[pageControl]|";
            break;
        }
            
        case PageControlPosition_BottomRight: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:[pageControl]-|";
            break;
        }
            
        default:
            break;
    }
    
    [self removeConstraints:self.pageControlConstraints];
    
    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vFormat
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hFormat
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    [self.pageControlConstraints removeAllObjects];
    [self.pageControlConstraints addObjectsFromArray:pageControlVConstraints];
    [self.pageControlConstraints addObjectsFromArray:pageControlHConstraints];
    
    [self addConstraints:self.pageControlConstraints];
}

- (void)setHidePageControl:(BOOL)hidePageControl
{
    self.pageControl.hidden = hidePageControl;
}


@end
