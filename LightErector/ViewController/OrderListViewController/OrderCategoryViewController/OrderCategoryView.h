//
//  OrderCategoryView.h
//  LightErector
//
//  Created by Jayden on 14-10-2.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "TitleBarAndScrollerView.h"
#import "CustomPullRefreshView.h"
#import "CustomSegmentedControl.h"

#define UNACCEPTTABLETAG 101
#define UNSUBTABLETAG 102
#define UNINSTALLTABLETAG 103
#define SUBAGAINTABLETAG 104
#define UNFEEDBACKTABLETAG 105
@protocol OrderCategoryViewDelegate<NSObject>
-(void)PullRefreshTableViewBottomRefresh:(UITableView *)tableView;
@end

@interface OrderCategoryView : TitleBarAndScrollerView
@property(nonatomic,strong)CustomSegmentedControl *segmentedControl;
@property(nonatomic,strong)CustomPullRefreshView *pullRefreshView;
@property(nonatomic,strong)UITableView *unAcceptTable;
@property(nonatomic,strong)UITableView *unSubTable;
@property(nonatomic,strong)UITableView *unInstallTable;
@property(nonatomic,strong)UITableView *subAgainTable;
@property(nonatomic,strong)UITableView *unFeedBackTable;
@property(nonatomic,weak)id<OrderCategoryViewDelegate> observer;

-(void)stopRefresh;
@end
