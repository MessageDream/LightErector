//
//  PullRefreshTableViewDelegate.h
//  pullRefreshTableView
//
//  Created by 95190 on 13-7-29.
//  Copyright (c) 2013年 sunhao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PullRefreshTableView;
@protocol PullRefreshTableViewDelegate <NSObject>
-(void)pullRefreshTableViewRefresh:(PullRefreshTableView*)pullRefreshTableView;
@optional
- (void)pullRefreshTableView:(PullRefreshTableView *)pullRefreshTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)pullRefreshTableView:(PullRefreshTableView *)pullRefreshTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)pullRefreshTableView:(PullRefreshTableView *)pullRefreshTableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)pullRefreshTableView:(PullRefreshTableView *)pullRefreshTableView heightForFooterInSection:(NSInteger)section;
- (UIView *)pullRefreshTableView:(PullRefreshTableView *)pullRefreshTableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)pullRefreshTableView:(PullRefreshTableView *)pullRefreshTableView viewForFooterInSection:(NSInteger)section;
-(UITableViewCellEditingStyle)pullRefreshTableView:(PullRefreshTableView *)pullRefreshTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)pullRefreshTableView:(PullRefreshTableView *)pullRefreshTableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
