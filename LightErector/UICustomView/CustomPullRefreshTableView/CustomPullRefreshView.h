//
//  CustomPullRefreshView.h
//  LightErector
//
//  Created by Jayden Zhao on 9/29/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^actionHandler)(void);
typedef NS_ENUM(NSUInteger, CustomPullRefreshViewState) {
    CustomPullRefreshViewStateNormal = 0,
    CustomPullRefreshViewStateStopped,
    CustomPullRefreshViewStateLoading,
};
typedef NS_ENUM(NSUInteger, CustomPullRefreshViewPosition) {
    CustomPullRefreshViewPositionTop,
    CustomPullRefreshViewPositionBottom,
    CustomPullRefreshViewPositionLeft,
    CustomPullRefreshViewPositionRight,
};

@interface CustomPullRefreshView : UIView

@property (nonatomic, assign) CGFloat originalInsetTop;
@property (nonatomic, assign) CGFloat originalInsetBottom;
@property (nonatomic, assign, readonly) CustomPullRefreshViewPosition position;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, copy) void (^pullToRefreshHandler)(CustomPullRefreshView *v);

// user customizable.
@property (nonatomic, assign) BOOL showPullToRefresh;
@property (nonatomic, assign) CGFloat threshold;
@property (nonatomic, strong) UIImage *imageIcon;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

- (id)initWithImage:(UIImage *)image position:(CustomPullRefreshViewPosition)position;
- (void)stopIndicatorAnimation;
- (void)manuallyTriggered;
- (void)setSize:(CGSize)size;

@end

@interface UIScrollView (CustomPullRefreshView)
- (CustomPullRefreshView *)addPullToRefreshPosition:(CustomPullRefreshViewPosition)position actionHandler:(void (^)(CustomPullRefreshView *v))handler;
@end
