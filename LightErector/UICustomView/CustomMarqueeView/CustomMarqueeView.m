//
//  CustomMarqueeUILable.m
//  G-NetLink
//
//  Created by jayden on 14-5-4.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import "CustomMarqueeView.h"
// Space between each subview item
#define kLPScrollingTickerHSpace                2.0f
// Default animation speed
#define kLPScrollingAnimationPixelsPerSecond    50.0f

@interface CustomMarqueeView() <UIScrollViewDelegate> {
    UIScrollView*                               scrollView;
    NSMutableArray*                             tickerSubViews;
    NSMutableArray*                             tickerSubviewsFrames;
    BOOL                                        isAnimating;
    NSUInteger                                  numberOfLoops;
    ScrollingDirection                        scrollViewDirection;
    CGFloat                                     scrollViewSpeed;
    NSUInteger                                  loopsDone;
    
    CADisplayLink*                              displayLink;
    
    ScrollingTickerLazyLoadingHandler         lazyLoadingHandler;
    ScrollingTickerAnimationCompletition      animationCompletitionHandler;
}

- (void) layoutTickerSubviewsWithItems:(NSArray *) itemsToLoad;
- (void) layoutTickerSubviewsWithItemSizes:(NSArray *) frameSizes;

- (void) pauseLayer:(CALayer *)layer;
- (void) resumeLayer:(CALayer *)layer;

- (void) beginAnimation;
- (CGPoint) startOffset;
@end

@implementation CustomMarqueeView
@synthesize isAnimating;
@synthesize contentSize,visibleContentRect;
@synthesize loopsDone;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        scrollViewDirection = ScrollingDirection_FromRight;
        numberOfLoops = 0;
        
        isAnimating = NO;
        tickerSubViews = nil;
        tickerSubviewsFrames = nil;
        
        scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        scrollView.delegate = self;
        
        [self addSubview:scrollView];
        self.backgroundColor = [UIColor clearColor];
        scrollView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) beginAnimationWithViews:(NSArray *) subviewsItems {
    [self beginAnimationWithViews:subviewsItems
                        direction:ScrollingDirection_FromRight
                            speed:0
                            loops:0
                     completition:^(NSUInteger loopsDone, BOOL isFinished) {}];
}

- (void) beginAnimationWithViews:(NSArray *) views
                       direction:(ScrollingDirection) scrollDirection
                           speed:(CGFloat) scrollSpeed
                           loops:(NSUInteger) loops
                    completition:(ScrollingTickerAnimationCompletition) completition {
    
    if (isAnimating) [self endAnimation:NO];
    
    lazyLoadingHandler = nil;
    animationCompletitionHandler = completition;
    numberOfLoops = loops;
    scrollViewDirection = scrollDirection;
    scrollViewSpeed = (scrollSpeed == 0 ? kLPScrollingAnimationPixelsPerSecond : scrollSpeed);
    
    if (displayLink) {
        [displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        displayLink = nil;
    }
    
    [self layoutTickerSubviewsWithItems:views];
    [self beginAnimation];
}

- (void) beginAnimationWithLazyViews:(ScrollingTickerLazyLoadingHandler) dataSource
                          itemsSizes:(NSArray *) subviewsSizes
                           direction:(ScrollingDirection) scrollDirection
                               speed:(CGFloat) scrollSpeed
                               loops:(NSUInteger) loops
                        completition:(ScrollingTickerAnimationCompletition) completition {
    
    if (isAnimating) [self endAnimation:NO];
    
    lazyLoadingHandler = dataSource;
    animationCompletitionHandler = completition;
    numberOfLoops = loops;
    scrollViewDirection = scrollDirection;
    scrollViewSpeed = (scrollSpeed == 0 ? kLPScrollingAnimationPixelsPerSecond : scrollSpeed);
    
    displayLink = [CADisplayLink displayLinkWithTarget: self
                                              selector: @selector(tickerDidScroll)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    [self layoutTickerSubviewsWithItemSizes:subviewsSizes];
    [self beginAnimation];
}

- (CGPoint) startOffset {
    CGPoint startOffset = CGPointZero;
    if (scrollViewDirection == ScrollingDirection_FromRight)
        startOffset = CGPointMake(-scrollView.frame.size.width, 0);
    else if (scrollViewDirection == ScrollingDirection_FromLeft)
        startOffset = CGPointMake(scrollView.contentSize.width, 0);
    return startOffset;
}

- (void) beginAnimation {
    if (isAnimating) return;
    [scrollView setContentOffset:[self startOffset]];
    
    isAnimating = YES;
    
    NSTimeInterval animationDuration = (scrollView.contentSize.width/scrollViewSpeed);
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CGPoint finalPoint = CGPointZero;
                         
                         if (scrollViewDirection == ScrollingDirection_FromRight)
                             finalPoint = CGPointMake(scrollView.contentSize.width, 0);
                         else if (scrollViewDirection == ScrollingDirection_FromLeft)
                             finalPoint = CGPointMake(-scrollView.contentSize.width+scrollView.frame.size.width, 0);
                         
                         scrollView.contentOffset = finalPoint;
                     } completion:^(BOOL finished) {
                         if (finished) {
                             isAnimating = NO;
                             BOOL restartAnimation = (numberOfLoops == 0 || loopsDone <= numberOfLoops);
                             
                             animationCompletitionHandler((loopsDone+1),!restartAnimation);
                             
                             if (restartAnimation)
                                 [self beginAnimation];
                             else
                                 [self endAnimation:NO];
                             
                             loopsDone++;
                         }
                     }];
}

- (void) endAnimation:(BOOL) animated {
    if (!isAnimating) return;
    isAnimating = NO;
    loopsDone = 0;
    
    [self pauseLayer:scrollView.layer];
    [self scrollToStart:animated];
}

- (void) pauseAnimation {
    if (!isAnimating) return;
    isAnimating = NO;
    [self pauseLayer:scrollView.layer];
}

- (void) resumeAnimation {
    if (isAnimating) return;
    isAnimating = YES;
    [self resumeLayer:scrollView.layer];
}

- (void) scrollToOffset:(CGPoint) offsetPoint animate:(BOOL) animated {
    [self endAnimation:NO];
    [scrollView setContentOffset:offsetPoint animated:animated];
}

- (void) scrollToStart:(BOOL) animated {
    [self endAnimation:NO];
    [scrollView setContentOffset:[self startOffset] animated:animated];
}

- (void) layoutSubviews {
    [super layoutSubviews];
}

- (CGSize) contentSize {
    return scrollView.contentSize;
}

- (void) layoutTickerSubviewsWithItemSizes:(NSArray *) frameSizes {
    tickerSubViews = [[NSMutableArray alloc] init];
    tickerSubviewsFrames = [[NSMutableArray alloc] init];
    
    CGSize scrollingContentSize = CGSizeZero;
    
    CGFloat offsetX = 0.0f;
    for (NSValue *itemSize in frameSizes) {
        CGRect itemFrame = CGRectMake(offsetX,
                                      0,
                                      [itemSize CGSizeValue].width,
                                      [itemSize CGSizeValue].height);
        [tickerSubviewsFrames addObject:[NSValue valueWithCGRect:itemFrame]];
        [tickerSubViews addObject:[NSNull null]];
        
        CGFloat itemWidth = ([itemSize CGSizeValue].width+kLPScrollingTickerHSpace);
        scrollingContentSize.width +=+itemWidth;
        scrollingContentSize.height = MAX(scrollingContentSize.height,[itemSize CGSizeValue].height);
        
        offsetX += itemWidth;
    }
    [scrollView setContentSize:scrollingContentSize];
}

- (void) layoutTickerSubviewsWithItems:(NSArray *) itemsToLoad {
    tickerSubViews = nil;
    tickerSubviewsFrames = [[NSMutableArray alloc] init];
    
    CGSize scrollingContentSize = CGSizeZero;
    CGFloat offsetX = 0.0f;
    for (UIView *itemView in itemsToLoad) {
        [itemView layoutSubviews];
        CGRect itemFrame = CGRectMake(offsetX,
                                      0,
                                      itemView.frame.size.width,
                                      itemView.frame.size.height);
        [tickerSubviewsFrames addObject:[NSValue valueWithCGRect:itemFrame]];
        CGFloat itemWidth = (itemView.frame.size.width+kLPScrollingTickerHSpace);
        scrollingContentSize.width +=+itemWidth;
        scrollingContentSize.height = MAX(scrollingContentSize.height,itemView.frame.size.height);
        offsetX += itemWidth;
        
        itemView.frame = itemFrame;
        [scrollView addSubview:itemView];
    }
    [scrollView setContentSize:scrollingContentSize];
}

- (CGRect) visibleContentRect {
    CGRect visibleRect;
    visibleRect.origin = [scrollView.layer.presentationLayer bounds].origin;
    visibleRect.size = scrollView.frame.size;
    return visibleRect;
}

- (void)tickerDidScroll {
    NSUInteger k = 0;
    CGRect visibleRect = self.visibleContentRect;
    for (NSValue* itemFrame in tickerSubviewsFrames) {
        BOOL isVisible = CGRectIntersectsRect(visibleRect, [itemFrame CGRectValue]);
        
        UIView *targetView = lazyLoadingHandler(k);
        if (isVisible && targetView.superview == nil) {
            targetView.frame = [itemFrame CGRectValue];
            [scrollView addSubview:targetView];
        } else if (isVisible == NO && targetView.superview != nil) {
            [targetView removeFromSuperview];
        }
        ++k;
    }
}

-(void)pauseLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}


-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if ((NSNull *)_contentViews!=[NSNull null]) {
        [self beginAnimationWithViews:_contentViews];
    }
}

@end
