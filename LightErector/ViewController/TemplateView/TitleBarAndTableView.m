//
//  TitleBarAndTableView.m
//  ZhiJiaX
//
//  Created by 95190 on 13-5-28.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "TitleBarAndTableView.h"

@implementation TitleBarAndTableView
@synthesize tableView = _tableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [_scrollerView removeFromSuperview];
        _scrollerView = nil;
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style
{
    self = [self initWithFrame:frame];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _customTitleBar.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_customTitleBar.bounds.size.height-20) style:style];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.scrollEnabled = YES;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.activeKeyboardControlOfScrollView = _tableView;
    [self addSubview:_tableView];
    
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
