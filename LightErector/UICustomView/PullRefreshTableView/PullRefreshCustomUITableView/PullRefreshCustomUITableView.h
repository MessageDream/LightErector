//
//  PullRefreshCustomUITableView.h
//  pullRefreshTableView
//
//  Created by 95190 on 13-7-29.
//  Copyright (c) 2013年 sunhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeforeIos7StyleOfTableView.h"

@interface PullRefreshCustomUITableView : BeforeIos7StyleOfTableView
{
@protected
    UIView *_belowRefreshView;
    CGRect tableViewRowChangeAfterFrame;
}
@property(nonatomic,readonly)UIView *belowRefreshView;
-(void)refresh;
-(void)stopRefresh;
@end
