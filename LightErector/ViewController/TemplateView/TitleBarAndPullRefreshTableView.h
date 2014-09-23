//
//  TitleBarAndPullRefreshTableView.h
//  ZhiJiaAnX
//
//  Created by 95190 on 13-7-29.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleBarView.h"
#import "PullRefreshTableView.h"
#import "PullRefreshShowView.h"

@interface TitleBarAndPullRefreshTableView : TitleBarView
{
@protected
    PullRefreshTableView *_tableView;
    PullRefreshShowView *_pullRefreshShowView;
}
@property(nonatomic,readonly)PullRefreshTableView *tableView;
@property(nonatomic,readonly)PullRefreshShowView *pullRefreshShowView;
-(id)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style;
@end
