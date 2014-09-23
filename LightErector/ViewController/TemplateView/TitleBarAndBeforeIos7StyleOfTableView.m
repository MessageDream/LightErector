//
//  TitleBarAndBeforeIos7StyleOfTableView.m
//  ZhiJiaAnX
//
//  Created by 95190 on 13-12-13.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "TitleBarAndBeforeIos7StyleOfTableView.h"

@implementation TitleBarAndBeforeIos7StyleOfTableView
@synthesize tableView = _tableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style
{
    self = [self initWithFrame:frame];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]<7)
    {
        _tableView = [[BeforeIos7StyleOfTableView alloc] initWithFrame:CGRectMake(0, _customTitleBar.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_customTitleBar.bounds.size.height-20) style:style];
    }
    else
    {
        _tableView = [[BeforeIos7StyleOfTableView alloc] initWithFrame:CGRectMake(10, _customTitleBar.frame.size.height+5, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.height-_customTitleBar.bounds.size.height-20) style:style];
    }
//    _tableView.style = UITableViewStylePlain;
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
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
