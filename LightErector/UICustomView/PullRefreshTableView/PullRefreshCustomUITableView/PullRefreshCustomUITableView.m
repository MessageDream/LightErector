//
//  PullRefreshCustomUITableView.m
//  pullRefreshTableView
//
//  Created by 95190 on 13-7-29.
//  Copyright (c) 2013年 sunhao. All rights reserved.
//

#import "PullRefreshCustomUITableView.h"

#define AnimationTime 0.5
#define ContentInsetHeight 20
#define RefreshViewHeight 50

@interface PullRefreshCustomUITableView()
{
    
}
-(void)animationDidStop;
@end

@implementation PullRefreshCustomUITableView
@synthesize belowRefreshView = _belowRefreshView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundView = nil;
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        int y = self.bounds.size.height;
        _belowRefreshView = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.bounds.size.width, RefreshViewHeight)];
        _belowRefreshView.backgroundColor = [UIColor clearColor];
        [self addSubview:_belowRefreshView];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    self.backgroundView = nil;
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    int y = self.bounds.size.height;
    _belowRefreshView = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.bounds.size.width, RefreshViewHeight)];
    _belowRefreshView.backgroundColor = [UIColor clearColor];
    [self addSubview:_belowRefreshView];
    return self;
}
-(void)refresh
{
    self.scrollEnabled = NO;
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:AnimationTime];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.contentInset = UIEdgeInsetsMake(0, 0, RefreshViewHeight+ContentInsetHeight, 0);
    [UIView commitAnimations];
}
-(void)stopRefresh
{
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:AnimationTime];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [UIView commitAnimations];
}
-(void)animationDidStop
{
    if(self.delegate == nil)
        return;
    self.scrollEnabled = YES;
    [self reloadData];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    tableViewRowChangeAfterFrame = [self rectForSection:0];
    for(int n=1;n<[self numberOfSections];n++)
    {
        CGRect sectionFrame = [self rectForSection:n];
        tableViewRowChangeAfterFrame.size.height+=sectionFrame.size.height;
    }
    CGRect belowRefreshViewFrame = _belowRefreshView.frame;
    
    if(tableViewRowChangeAfterFrame.size.height>self.bounds.size.height)
        belowRefreshViewFrame.origin.y = tableViewRowChangeAfterFrame.size.height;
    else
    {
        self.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        belowRefreshViewFrame.origin.y = self.bounds.size.height;
    }
    _belowRefreshView.frame = belowRefreshViewFrame;
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
