//
//  TitleBarAndPullRefreshTableView.m
//  ZhiJiaAnX
//
//  Created by 95190 on 13-7-29.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "TitleBarAndPullRefreshTableView.h"

@implementation TitleBarAndPullRefreshTableView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _tableView = [[CustomPullRefreshTableView alloc] initWithFrame:CGRectMake(0, _customTitleBar.frame.size.height, self.bounds.size.width, self.bounds.size.height-_customTitleBar.bounds.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.pullRefreshViewPositionBottomEnable=YES;
        [self addSubview:_tableView];
    }
    
    return self;
}
-(id)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _tableView = [[CustomPullRefreshTableView alloc] initWithFrame:CGRectMake(0, _customTitleBar.frame.size.height, self.bounds.size.width, self.bounds.size.height-_customTitleBar.bounds.size.height) style:style];
        _tableView.backgroundColor = [UIColor clearColor];
          _tableView.pullRefreshViewPositionBottomEnable=YES;
        [self addSubview:_tableView];
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
