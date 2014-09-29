//
//  TitleBarAndPullRefreshTableView.h
//  ZhiJiaAnX
//
//  Created by 95190 on 13-7-29.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleBarView.h"
#import "CustomPullRefreshTableView.h"

@interface TitleBarAndPullRefreshTableView : TitleBarView
{
@protected
    CustomPullRefreshTableView *_tableView;
}
@property(nonatomic,readonly)CustomPullRefreshTableView *tableView;
-(id)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style;
@end
