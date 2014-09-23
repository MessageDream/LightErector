//
//  PullRefreshTableView.m
//  pullRefreshTableView
//
//  Created by 95190 on 13-7-29.
//  Copyright (c) 2013年 sunhao. All rights reserved.
//

#import "PullRefreshTableView.h"
#import "PullRefreshCustomUITableView.h"

@implementation PullRefreshTableView
@synthesize belowRefreshView = _belowRefreshView;
@synthesize separatorStyle = _separatorStyle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        frame.origin.x = 0;
        frame.origin.y = 0;
        _tableView = [[PullRefreshCustomUITableView alloc] initWithFrame:frame];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        self.useBeforeIos7Style = NO;
        _belowRefreshView = _tableView.belowRefreshView;
        [self addSubview:_tableView];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    frame.origin.x = 0;
    frame.origin.y = 0;
    _tableView = [[PullRefreshCustomUITableView alloc] initWithFrame:frame style:style];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.useBeforeIos7Style = NO;
    _belowRefreshView = _tableView.belowRefreshView;
    [self addSubview:_tableView];
    return self;
}
-(void)setSeparatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
{
    _separatorStyle = separatorStyle;
    _tableView.separatorStyle = separatorStyle;
}
-(NSArray*)visibleCells
{
    return [_tableView visibleCells];
}
-(NSIndexPath*)indexPathForCell:(UITableViewCell*)cell
{
    return [_tableView indexPathForCell:cell];
}
-(UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_tableView cellForRowAtIndexPath:indexPath];
}
-(void)stopRefresh
{
    [_tableView stopRefresh];
}
-(void)reloadData
{
    [_tableView reloadData];
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [_tableView setEditing:editing animated:animated];
}
-(void)setEditing:(BOOL)editing
{
    [_tableView setEditing:editing];
}
-(BOOL)editing
{
    return _tableView.editing;
}
-(void)setUseBeforeIos7Style:(BOOL)useBeforeIos7Style
{
    _useBeforeIos7Style = useBeforeIos7Style;
    _tableView.useBeforeIos7Style = useBeforeIos7Style;
}
-(void)setTableViewFrame:(CGRect)frame
{
    self.frame = frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    _tableView.frame = frame;
}
-(void)setDataSource:(id<UITableViewDataSource>)dataSource
{
    _dataSource = dataSource;
}
-(void)setFrame:(CGRect)frame
{
    super.frame = frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    _tableView.frame = frame;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(scrollView.contentOffset.y+scrollView.bounds.size.height>scrollView.contentSize.height+_belowRefreshView.frame.size.height)
    {
        [_tableView refresh];
        if(self.observer!=nil)
            [self.observer pullRefreshTableViewRefresh:self];
    }
}
-(id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    return [_tableView dequeueReusableCellWithIdentifier:identifier];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource tableView:(UITableView *)self cellForRowAtIndexPath:indexPath];
}
-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource tableView:(UITableView*)self numberOfRowsInSection: section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)])
        return [self.dataSource numberOfSectionsInTableView:tableView];
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.observer respondsToSelector:@selector(pullRefreshTableView:didSelectRowAtIndexPath:)])
        [self.observer pullRefreshTableView:self didSelectRowAtIndexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.observer respondsToSelector:@selector(pullRefreshTableView:heightForRowAtIndexPath:)])
    {
        return [self.observer pullRefreshTableView:self heightForRowAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.observer respondsToSelector:@selector(pullRefreshTableView:heightForHeaderInSection:)])
        return [self.observer pullRefreshTableView:self heightForHeaderInSection:section];
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.observer respondsToSelector:@selector(pullRefreshTableView:heightForFooterInSection:)])
        return [self.observer pullRefreshTableView:self heightForFooterInSection:section];
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.observer respondsToSelector:@selector(pullRefreshTableView:viewForHeaderInSection:)])
        return [self.observer pullRefreshTableView:self viewForHeaderInSection:section];
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.observer respondsToSelector:@selector(pullRefreshTableView:viewForFooterInSection:)])
        return [self.observer pullRefreshTableView:self viewForFooterInSection:section];
    return nil;
}
-(NSIndexPath *)indexPathForSelectedRow
{
    return [_tableView indexPathForSelectedRow];
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.observer respondsToSelector:@selector(pullRefreshTableView:editingStyleForRowAtIndexPath:)])
        return [self.observer pullRefreshTableView:self editingStyleForRowAtIndexPath:indexPath];
    return UITableViewCellEditingStyleNone;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.observer respondsToSelector:@selector(pullRefreshTableView:didDeselectRowAtIndexPath:)])
        return [self.observer pullRefreshTableView:self didDeselectRowAtIndexPath:indexPath];
}
-(void)dealloc
{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
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
