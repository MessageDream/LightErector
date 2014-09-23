//
//  PullRefreshTableView.h
//  pullRefreshTableView
//
//  Created by 95190 on 13-7-29.
//  Copyright (c) 2013年 sunhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewDelegate.h"
@class PullRefreshCustomUITableView;

@interface PullRefreshTableView : UIView<UITableViewDelegate,UIScrollViewDelegate,UITableViewDataSource>
{
@protected
    UIView *_belowRefreshView;
    CGRect tableViewRowChangeAfterFrame;
    PullRefreshCustomUITableView *_tableView;
    UITableViewCellSeparatorStyle _separatorStyle;
    BOOL _useBeforeIos7Style;
}
@property(nonatomic)BOOL editing;
@property(nonatomic)BOOL useBeforeIos7Style;
@property(nonatomic)UITableViewCellSeparatorStyle separatorStyle;
@property(nonatomic,readonly)UIView *belowRefreshView;
@property(nonatomic,assign)id<UITableViewDataSource> dataSource;
@property(nonatomic,assign)id<PullRefreshTableViewDelegate> observer;
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
-(void)stopRefresh;
-(void)setTableViewFrame:(CGRect)frame;
-(NSArray*)visibleCells;
-(NSIndexPath*)indexPathForCell:(UITableViewCell*)cell;
-(UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
-(NSIndexPath *)indexPathForSelectedRow;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
-(void)reloadData;
@end
