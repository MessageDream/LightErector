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
    CustomPullRefreshView *topView;
    CustomPullRefreshView *bottomView;
    CustomPullRefreshView *leftView;
    CustomPullRefreshView *rightView;
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
    if (topView) {
        [topView stopIndicatorAnimation];
    }
    if (bottomView) {
        [bottomView stopIndicatorAnimation];
    }
    if (leftView) {
        [leftView stopIndicatorAnimation];
    }
    if (rightView) {
        [rightView stopIndicatorAnimation];
    }
}

-(void)setPullRefreshViewPositionTopEnable:(BOOL)pullRefreshViewPositionTopEnable
{
    _pullRefreshViewPositionTopEnable=pullRefreshViewPositionTopEnable;
    if (_pullRefreshViewPositionTopEnable) {
        __block CustomPullRefreshTableView *blockSelf=self;
         topView=[self addPullToRefreshPosition:CustomPullRefreshViewPositionTop actionHandler:^(CustomPullRefreshView *v) {
             if (blockSelf.pullRefreshDelegate!=nil) {
                  [blockSelf.pullRefreshDelegate PullRefreshTableViewTopRefresh:blockSelf];
             }
         }];
        topView.imageIcon = [UIImage imageNamed:@"launchpad"];
        topView.borderColor = [UIColor whiteColor];

    }else{
        [topView removeFromSuperview];
    }
   
}

-(void)setPullRefreshViewPositionBottomEnable:(BOOL)pullRefreshViewPositionBottomEnable
{
    _pullRefreshViewPositionBottomEnable=pullRefreshViewPositionBottomEnable;
    if (_pullRefreshViewPositionBottomEnable) {
        __block CustomPullRefreshTableView *blockSelf=self;
        bottomView=[self addPullToRefreshPosition:CustomPullRefreshViewPositionBottom actionHandler:^(CustomPullRefreshView *v) {
            if (blockSelf.pullRefreshDelegate!=nil) {
                [blockSelf.pullRefreshDelegate PullRefreshTableViewBottomRefresh:blockSelf];
            }
        }];
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
        __block CustomPullRefreshTableView *blockSelf=self;
        leftView=[self addPullToRefreshPosition:CustomPullRefreshViewPositionLeft actionHandler:^(CustomPullRefreshView *v) {
            if (blockSelf.pullRefreshDelegate!=nil) {
                 [blockSelf.pullRefreshDelegate PullRefreshTableViewLeftRefresh:blockSelf];
            }
        }];
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
        __block CustomPullRefreshTableView *blockSelf=self;
        rightView=[self addPullToRefreshPosition:CustomPullRefreshViewPositionRight actionHandler:^(CustomPullRefreshView *v) {
            if (blockSelf.pullRefreshDelegate!=nil) {
                 [blockSelf.pullRefreshDelegate PullRefreshTableViewRightRefresh:blockSelf];
            }
        }];
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
    self.pullRefreshDelegate=nil;
    topView=nil;
    bottomView=nil;
    leftView=nil;
    rightView=nil;
}
@end
