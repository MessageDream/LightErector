//
//  CustomMarqueeUILable.h
//  G-NetLink
//
//  Created by jayden on 14-5-4.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIView* (^ScrollingTickerLazyLoadingHandler)(NSUInteger indexOfViewToShow);
typedef void (^ScrollingTickerAnimationCompletition)(NSUInteger loopsDone, BOOL isFinished);


enum {
    ScrollingDirection_FromLeft = 0,
    ScrollingDirection_FromRight = 1
};
typedef NSUInteger ScrollingDirection;

@interface CustomMarqueeView : UIView
@property (nonatomic,readonly)BOOL isAnimating;
@property (nonatomic,readonly)NSUInteger loopsDone;
@property (nonatomic,readonly)CGSize contentSize;
@property (nonatomic,readonly)CGRect visibleContentRect;
@property (nonatomic)NSArray *contentViews;


- (id)initWithFrame:(CGRect)frame;

- (void) beginAnimationWithLazyViews:(ScrollingTickerLazyLoadingHandler) dataSource itemsSizes:(NSArray *) subviewsSizes
                           direction:(ScrollingDirection) scrollDirection
                               speed:(CGFloat) scrollSpeed
                               loops:(NSUInteger) loops
                        completition:(ScrollingTickerAnimationCompletition) completition;

- (void) beginAnimationWithViews:(NSArray *) subviewsItems
                       direction:(ScrollingDirection) scrollDirection
                           speed:(CGFloat) scrollSpeed
                           loops:(NSUInteger) loops
                    completition:(ScrollingTickerAnimationCompletition) completition;

- (void) beginAnimationWithViews:(NSArray *) subviewsItems;
- (void) endAnimation:(BOOL) animated;
- (void) pauseAnimation;
- (void) resumeAnimation;
- (void) scrollToOffset:(CGPoint) offsetPoint animate:(BOOL) animated;
- (void) scrollToStart:(BOOL) animated;
@end
