//
//  CustomPullRefreshTableView.h
//  LightErector
//
//  Created by Jayden Zhao on 9/29/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPullRefreshView.h"
@class CustomPullRefreshTableView;
@protocol CustomPullRefreshTableViewDelegate <NSObject>
@optional
-(void)PullRefreshTableViewTopRefresh:(CustomPullRefreshTableView *)tableView;
-(void)PullRefreshTableViewBottomRefresh:(CustomPullRefreshTableView *)tableView;
-(void)PullRefreshTableViewLeftRefresh:(CustomPullRefreshTableView *)tableView;
-(void)PullRefreshTableViewRightRefresh:(CustomPullRefreshTableView *)tableView;
@end

@interface CustomPullRefreshTableView : UITableView
@property(nonatomic,assign)BOOL pullRefreshViewPositionTopEnable;
@property(nonatomic,assign)BOOL pullRefreshViewPositionBottomEnable;
@property(nonatomic,assign)BOOL pullRefreshViewPositionLeftEnable;
@property(nonatomic,assign)BOOL pullRefreshViewPositionRightEnable;
@property(nonatomic,weak)id<CustomPullRefreshTableViewDelegate> pullRefreshDelegate;

-(void)stopRefresh;
-(void)setTopPullRefreshViewImage:(UIImage *)image andBorderColor:(UIColor *)color;
-(void)setBottomPullRefreshViewImage:(UIImage *)image andBorderColor:(UIColor *)color;
-(void)setLeftPullRefreshViewImage:(UIImage *)image andBorderColor:(UIColor *)color;
-(void)setRightPullRefreshViewImage:(UIImage *)image andBorderColor:(UIColor *)color;
@end
