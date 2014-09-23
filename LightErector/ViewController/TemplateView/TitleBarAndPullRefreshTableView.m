//
//  TitleBarAndPullRefreshTableView.m
//  ZhiJiaAnX
//
//  Created by 95190 on 13-7-29.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "TitleBarAndPullRefreshTableView.h"

@implementation TitleBarAndPullRefreshTableView
@synthesize pullRefreshShowView = _pullRefreshShowView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _tableView = [[PullRefreshTableView alloc] initWithFrame:CGRectMake(0, _customTitleBar.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_customTitleBar.bounds.size.height-30)];
        _tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:_tableView];
        
        CGRect frame = _tableView.belowRefreshView.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        _pullRefreshShowView = [[PullRefreshShowView alloc] initWithFrame:frame];
        _pullRefreshShowView.readyText = NSLocalizedStringFromTable(@"PullLoad",Res_String,@"");        _pullRefreshShowView.refreshText = NSLocalizedStringFromTable(@"StartResfresh",Res_String,@"");
        [_pullRefreshShowView ready];
        [_tableView.belowRefreshView addSubview:_pullRefreshShowView];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _tableView = [[PullRefreshTableView alloc] initWithFrame:CGRectMake(0, _customTitleBar.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_customTitleBar.bounds.size.height-30) style:style];
        _tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:_tableView];
        
        CGRect frame = _tableView.belowRefreshView.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        _pullRefreshShowView = [[PullRefreshShowView alloc] initWithFrame:frame];
        _pullRefreshShowView.readyText = NSLocalizedStringFromTable(@"PullLoad",Res_String,@"");
        _pullRefreshShowView.refreshText = NSLocalizedStringFromTable(@"StartResfresh",Res_String,@"");
        [_pullRefreshShowView ready];
        [_tableView.belowRefreshView addSubview:_pullRefreshShowView];
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
