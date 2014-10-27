//
//  CustomPullRefreshTableView.m
//  LightErector
//
//  Created by Jayden Zhao on 9/29/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "CustomPullRefreshTableView.h"
@interface CustomPullRefreshTableView ()
{
    __weak  CustomPullRefreshView *currentView;
  __weak  CustomPullRefreshView *topView;
  __weak  CustomPullRefreshView *bottomView;
  __weak  CustomPullRefreshView *leftView;
  __weak  CustomPullRefreshView *rightView;
}
@end
@implementation CustomPullRefreshTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)stopRefresh
{
    if (currentView) {
        [currentView stopIndicatorAnimation];
    }
}

-(void)setPullRefreshViewPositionTopEnable:(BOOL)pullRefreshViewPositionTopEnable
{
    _pullRefreshViewPositionTopEnable=pullRefreshViewPositionTopEnable;
    if (_pullRefreshViewPositionTopEnable) {
        if (topView) {
            [topView removeFromSuperview];
        }
        __weak CustomPullRefreshTableView *blockSelf=self;
         topView=[self addPullToRefreshPosition:CustomPullRefreshViewPositionTop actionHandler:^(CustomPullRefreshView *v) {
             if (blockSelf.pullRefreshDelegate!=nil) {
                  [blockSelf.pullRefreshDelegate PullRefreshTableViewTopRefresh:blockSelf];
             }
         }];
        topView.imageIcon = [UIImage imageNamed:@"launchpad"];
        topView.borderColor = [UIColor whiteColor];
        currentView=topView;
    }else{
        [topView removeFromSuperview];
    }
   
}

-(void)setPullRefreshViewPositionBottomEnable:(BOOL)pullRefreshViewPositionBottomEnable
{
    _pullRefreshViewPositionBottomEnable=pullRefreshViewPositionBottomEnable;
    if (_pullRefreshViewPositionBottomEnable) {
        if (bottomView) {
            [bottomView removeFromSuperview];
        }
        __weak CustomPullRefreshTableView *blockSelf=self;
        bottomView=[self addPullToRefreshPosition:CustomPullRefreshViewPositionBottom actionHandler:^(CustomPullRefreshView *v) {
            if (blockSelf.pullRefreshDelegate!=nil) {
                [blockSelf.pullRefreshDelegate PullRefreshTableViewBottomRefresh:blockSelf];
            }
        }];
         currentView=bottomView;
        bottomView.imageIcon = [UIImage imageNamed:@"launchpad"];
        bottomView.borderColor = [UIColor whiteColor];
        
    }else{
        [bottomView removeFromSuperview];
    }
}

-(void)setPullRefreshViewPositionLeftEnable:(BOOL)pullRefreshViewPositionLeftEnable
{
    _pullRefreshViewPositionLeftEnable=pullRefreshViewPositionLeftEnable;
    if (_pullRefreshViewPositionLeftEnable) {
        if (leftView) {
            [leftView removeFromSuperview];
        }
        __weak CustomPullRefreshTableView *blockSelf=self;
        leftView=[self addPullToRefreshPosition:CustomPullRefreshViewPositionLeft actionHandler:^(CustomPullRefreshView *v) {
            if (blockSelf.pullRefreshDelegate!=nil) {
                 [blockSelf.pullRefreshDelegate PullRefreshTableViewLeftRefresh:blockSelf];
            }
        }];
          currentView=leftView;
        leftView.imageIcon = [UIImage imageNamed:@"launchpad"];
        leftView.borderColor = [UIColor whiteColor];
        
    }else{
        [leftView removeFromSuperview];
    }
}

-(void)setPullRefreshViewPositionRightEnable:(BOOL)pullRefreshViewPositionRightEnable
{
    _pullRefreshViewPositionRightEnable=pullRefreshViewPositionRightEnable;
    if (_pullRefreshViewPositionRightEnable) {
        if (rightView) {
            [rightView removeFromSuperview];
        }
        __weak CustomPullRefreshTableView *blockSelf=self;
        rightView=[self addPullToRefreshPosition:CustomPullRefreshViewPositionRight actionHandler:^(CustomPullRefreshView *v) {
            if (blockSelf.pullRefreshDelegate!=nil) {
                 [blockSelf.pullRefreshDelegate PullRefreshTableViewRightRefresh:blockSelf];
            }
        }];
        currentView=rightView;
        rightView.imageIcon = [UIImage imageNamed:@"launchpad"];
        rightView.borderColor = [UIColor whiteColor];
        
    }else{
        [rightView removeFromSuperview];
    }
}

-(void)setTopPullRefreshViewImage:(UIImage *)image andBorderColor:(UIColor *)color
{
    if (topView) {
        topView.imageIcon =image;
        topView.borderColor = color;

    }
}

-(void)setBottomPullRefreshViewImage:(UIImage *)image andBorderColor:(UIColor *)color
{
    if (bottomView) {
    bottomView.imageIcon =image;
    bottomView.borderColor = color;
    
}
}

-(void)setLeftPullRefreshViewImage:(UIImage *)image andBorderColor:(UIColor *)color
{
    if (leftView) {
        leftView.imageIcon =image;
        leftView.borderColor = color;
        
    }}

-(void)setRightPullRefreshViewImage:(UIImage *)image andBorderColor:(UIColor *)color
{
    if (rightView) {
        rightView.imageIcon =image;
        rightView.borderColor = color;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc
{
    [self removeObserver:currentView forKeyPath:@"contentOffset"];
    [self removeObserver:currentView forKeyPath:@"contentSize"];
    [self removeObserver:currentView forKeyPath:@"frame"];
    _pullRefreshDelegate=nil;
    topView=nil;
    bottomView=nil;
    leftView=nil;
    rightView=nil;
}
@end
